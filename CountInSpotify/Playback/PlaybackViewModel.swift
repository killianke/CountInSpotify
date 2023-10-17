//
//  PlaybackViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 17/10/2023.
//

import Foundation
import CoreAudioKit
import SpotifyiOS

class PlaybackViewModel: NSObject, ObservableObject, SPTAppRemoteDelegate {
    
    @Published var error: Error?

    private var spotifyRemote: SPTAppRemote?
    
    private let track: Track

    init(track: Track) {
        self.track = track
        super.init()
        
        SpotifyConnectionManager.shared.connectionDelegate = self
        
        spotifyRemote = SpotifyConnectionManager.shared.remote
        if spotifyRemote?.isConnected ?? false {
            playTrack(track)
        }
    }
    
    //MARK: Computed properties
    
    var trackInfoViewModel: TrackInfoViewModel {
        TrackInfoViewModel(track: track)
    }
    
    func playTrack(_ track: Track) {
        guard let playerAPI = spotifyRemote?.playerAPI else {
            return
        }
        
        playerAPI.play(Constants.spotifySilentTrackId)
                
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
//                print("KK ----- double: \(adjustedStartTime) milli: \(startTimeMilliseconds)")
                playerAPI.seek(toPosition: startTimeMilliseconds)
            }
        }
        
        metronome.start(forBars: 2)
    }
    
    //MARK: SPTAppRemoteDelegate
    
    @objc func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.spotifyRemote = appRemote
        playTrack(self.track)
    }
    
    @objc func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        self.error = error
    }
    
    @objc func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        self.error = error
    }
}
