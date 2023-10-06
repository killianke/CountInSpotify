//
//  TracksStore.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 06/10/2023.
//

import Foundation

final class TrackStore: ObservableObject {
    
    @Published var tracks: [SpotifyTrack] = []
    
    func addTrack(_ track: SpotifyTrack) {
        tracks.append(track)
    }
    
    //TODO: Add backing storage for tracks
}
