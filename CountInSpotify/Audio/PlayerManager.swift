//
//  PlaybackManager.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 17/10/2023.
//

import Foundation
import CoreAudioKit
import SpotifyiOS

class PlayerManager: NSObject, ObservableObject, SPTAppRemoteDelegate {
    
    @Published var error: Error? {
        didSet {
            if error == nil {
                connecting = false
            }
        }
    }
    @Published var connecting: Bool = false
    
    private var spotifyRemote: SPTAppRemote?
    private var pendingPlayTrack: (()->())?
    private var stopPlaybackTask: DispatchWorkItem?
    
    override init() {
        super.init()
        SpotifyConnectionManager.shared.remoteDelegate = self
        spotifyRemote = SpotifyConnectionManager.shared.remote
    }
    
    func playTrack(_ track: Track, for duration: TimeInterval? = nil) {
        guard let remote = spotifyRemote, remote.isConnected,
                let playerAPI = remote.playerAPI else {
            
            if error == nil {
                connecting = true
                pendingPlayTrack = { self.playTrack(track) }
            }
            return
        }
        
        stopPlaybackTask?.cancel()
        pendingPlayTrack = nil
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
        
        metronome.start(forBars: 2)
    }
    
    @objc func stopPlaying() {
        //Pausing player will make remote disconnect
        if let playerAPI = spotifyRemote?.playerAPI {
            playerAPI.play(Constants.spotifySilentTrackId)
            playerAPI.setRepeatMode(.track)
        }
    }
    
    //MARK: SPTAppRemoteDelegate
    
    @objc func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.spotifyRemote = appRemote
        pendingPlayTrack?()
    }
    
    @objc func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        self.error = error
    }
    
    @objc func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        self.error = error
    }
}
