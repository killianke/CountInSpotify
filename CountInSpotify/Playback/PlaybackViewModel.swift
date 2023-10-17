//
//  PlaybackViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 17/10/2023.
//

import Foundation

class PlaybackViewModel: ObservableObject {
    
    private var track: Track

    init(track: Track) {
        self.track = track
    }
    
    //MARK: Computed properties
    
    var trackInfoViewModel: TrackInfoViewModel {
        TrackInfoViewModel(track: track)
    }
}
