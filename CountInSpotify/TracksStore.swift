//
//  TracksStore.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 06/10/2023.
//

import Foundation

final class TrackStore: ObservableObject {
    
    @Published var tracks: [Track] = []
    
    func addTrack(_ track: Track) {
        tracks.append(track)
    }
    
    //TODO: Add backing storage for tracks
}
