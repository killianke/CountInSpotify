//
//  PlaybackManager.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 17/10/2023.
//

import Foundation
import CoreAudioKit
import SpotifyiOS

class PlayerManager {
        
    @Published var isCountingIn: Bool = false
    
    private var spotifyRemote: SPTAppRemote?
    private var stopPlaybackTask: DispatchWorkItem?
    private var currentTrack: Track?
    private var pausedTime: Int?
    
    var isPaused: Bool {
        return pausedTime != nil
    }
    
    func setRemote(_ remote: SPTAppRemote) {
        self.spotifyRemote = remote
    }
    
    func playTrack(_ track: Track, for duration: TimeInterval? = nil) {
        guard let remote = spotifyRemote, remote.isConnected,
                let playerAPI = remote.playerAPI, !isCountingIn else {
            return
        }
                
        currentTrack = track
        pausedTime = nil
        stopPlaybackTask?.cancel()
        playerAPI.play(Constants.spotifySilentTrackId)
        
        if let delay = duration {
            stopPlaybackTask = DispatchWorkItem {
                self.stopPlaying()
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
            self.isCountingIn = false
        }
        
        isCountingIn = true
        metronome.start(forBars: track.countInBars)
    }
    
    func pause() {
        guard !isCountingIn else {
            return
        }

        spotifyRemote?.playerAPI?.getPlayerState({ result, error in
            if let state = result as? SPTAppRemotePlayerState {
                self.pausedTime = state.playbackPosition
                self.stopPlaying()
            }
        })
    }
    
    func resume() {
        if let playerAPI = spotifyRemote?.playerAPI,
            let track = currentTrack {
            playerAPI.setRepeatMode(.off)
            playerAPI.play(track.uri)
            if let position = pausedTime {
                playerAPI.seek(toPosition: position)
                pausedTime = nil
            }
        }
    }
    
    @objc func stopPlaying() {
        //Pausing player will make remote disconnect
        if let playerAPI = spotifyRemote?.playerAPI {
            playerAPI.play(Constants.spotifySilentTrackId)
            playerAPI.setRepeatMode(.track)
        }
    }
}
