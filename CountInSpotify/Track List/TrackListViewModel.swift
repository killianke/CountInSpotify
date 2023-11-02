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
    
    private let player = PlayerManager()

    override init() {
        super.init()
        SpotifyConnectionManager.shared.remoteDelegate = self
        player.setRemote(SpotifyConnectionManager.shared.remote)
    }
    
    func setTrackStore(_ store: TrackStoreProtocol) {
        self.store = store
    }
    
    func playTrack(_ track: Track) {
        player.playTrack(track)
    }
    
    func deleteTrack(_ track: Track) {
        store.deleteTrack(track)
    }

    //MARK: SPTAppRemoteDelegate

    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.spotifyRemote = appRemote
        player.setRemote(appRemote)
    }

    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        self.error = error
    }

    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        self.error = error
    }
}
