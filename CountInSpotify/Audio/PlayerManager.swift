//
//  PlaybackManager.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 17/10/2023.
//

import Foundation
import CoreAudioKit
import SpotifyiOS

class PlayerManager: NSObject {
        
    private var spotifyRemote: SPTAppRemote?
    private var stopPlaybackTask: DispatchWorkItem?
    
    func setRemote(_ remote: SPTAppRemote) {
        self.spotifyRemote = remote
    }
    
    func playTrack(_ track: Track, for duration: TimeInterval? = nil, countInBars: Int = 1) {
        guard let remote = spotifyRemote, remote.isConnected,
                let playerAPI = remote.playerAPI else {
            return
        }
        
        stopPlaybackTask?.cancel()
        playerAPI.play(Constants.spotifySilentTrackId)
        
        if let delay = duration {
            stopPlaybackTask = DispatchWorkItem {
                playerAPI.play(Constants.spotifySilentTrackId)
                playerAPI.setRepeatMode(.track)
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: stopPlaybackTask!)
        }
                
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
        
        guard let trackBPM = track.bpm else {
            return
        }

        let metronome = Metronome(bpm: trackBPM)
        
        metronome.didStopClosure = {
            playerAPI.setRepeatMode(.off)
            playerAPI.play(track.uri)
            if let adjustedStartTime = track.startTime {
                let startTimeMilliseconds = Int(adjustedStartTime * 1000)
                playerAPI.seek(toPosition: startTimeMilliseconds)
            }
        }
        
        metronome.start(forBars: countInBars)
    }
    
    @objc func stopPlaying() {
        //Pausing player will make remote disconnect
        if let playerAPI = spotifyRemote?.playerAPI {
            playerAPI.play(Constants.spotifySilentTrackId)
            playerAPI.setRepeatMode(.track)
        }
    }
}
