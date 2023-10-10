//
//  TrackListViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/10/2023.
//

import Foundation
import CoreAudioKit

class TrackListViewModel: NSObject, ObservableObject, SPTAppRemoteDelegate {
    
    @Published var error: Error?
    
    private var spotifyRemote: SPTAppRemote?
    
    override init() {
        super.init()
        SpotifyConnectionManager.shared.connectionDelegate = self
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.spotifyRemote = appRemote
    }
    
    func playTrack(_ track: Track) {
        guard let remote = spotifyRemote else {
            return
        }
        
        remote.playerAPI?.play(Constants.spotifySilentTrackId)
                
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
            remote.playerAPI?.play(track.uri)
            if let adjustedStartTime = track.startTime {
                remote.playerAPI?.seek(toPosition: Int(adjustedStartTime))
            }
        }
        
        metronome.start(forBars: 1)
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        self.error = error
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        self.error = error
    }
}
