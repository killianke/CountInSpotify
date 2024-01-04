//
//  TrackListViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/10/2023.
//

import Foundation
import CoreAudioKit
import SpotifyiOS

class TrackListViewModel: NSObject, ObservableObject, SpotifyConnectionDelegate {
    
    @Published var error: Error?
    @Published var nowPlayingViewModel: NowPlayingViewModel?
    @Published var presentAppStore: Bool = false
    
    let appStoreListingId = "\(SPTAppRemote.spotifyItunesItemIdentifier())"
    
    private var spotifyRemote: SPTAppRemote
    private var store: TrackStoreProtocol!
    
    override init() {
        self.spotifyRemote = SpotifyConnectionManager.shared.remote
        super.init()
        SpotifyConnectionManager.shared.remoteDelegate = self
    }
    
    func setTrackStore(_ store: TrackStoreProtocol) {
        self.store = store
    }
    
    func playTrack(_ track: Track) {
        nowPlayingViewModel = NowPlayingViewModel(track: track, remote: spotifyRemote)
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
    
    func spotifyAppNotInstalled() {
        presentAppStore = true
    }
    
    func openSpotifyButtonTapped(urlOpener: URLOpener = URLOpener()) {
        if let url = URL(string: Constants.spotifyBaseURLScheme) {
            urlOpener.open(url: url)
        }
    }
}
