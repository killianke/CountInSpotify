//
//  TrackListViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/10/2023.
//

import Foundation
import CoreAudioKit
import SpotifyiOS

class TrackListViewModel: NSObject, ObservableObject, SPTAppRemoteDelegate {
    
    @Published var error: Error?
    
    private var spotifyRemote: SPTAppRemote?
    private var store: TrackStoreProtocol!

    override init() {
        super.init()
        SpotifyConnectionManager.shared.remoteDelegate = self
    }
    
    func setTrackStore(_ store: TrackStoreProtocol) {
        self.store = store
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
                playerAPI.seek(toPosition: Int(adjustedStartTime * 1000))
            }
        }
        
        metronome.start(forBars: 2)
    }
    
    func deleteTrack(_ track: Track) {
        store.deleteTrack(track)
    }
    
    //MARK: SPTAppRemoteDelegate
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.spotifyRemote = appRemote
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        self.error = error
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        self.error = error
    }
}
