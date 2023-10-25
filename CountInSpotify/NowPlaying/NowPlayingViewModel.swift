//
//  PlaybackViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 17/10/2023.
//

import Foundation

class NowPlayingViewModel: ObservableObject {
    
    @Published var error: Error?
    
    private let track: Track
    private let playback = PlayerManager()

    init(track: Track) {
        self.track = track
        playback.error = error
        playback.playTrack(track)
    }
    
    //MARK: Computed properties
    
    var trackInfoViewModel: TrackInfoViewModel {
        TrackInfoViewModel(track: track)
    }
}
