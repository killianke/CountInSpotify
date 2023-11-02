//
//  PlaybackViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 17/10/2023.
//

import Foundation

class NowPlayingViewModel: ObservableObject, Identifiable {
    
    @Published var error: Error?
    
    private let track: Track
    private let player = PlayerManager()

    init(track: Track, remote: SPTAppRemote) {
        self.track = track
        player.setRemote(remote)
        player.playTrack(track)
    }
    
    func restartTapped() {
        player.playTrack(track)
    }
    
    //MARK: Computed properties
    
    var trackInfoViewModel: TrackInfoViewModel {
        TrackInfoViewModel(track: track)
    }
}
