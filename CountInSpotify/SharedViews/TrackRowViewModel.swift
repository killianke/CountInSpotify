//
//  TrackRowViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 05/10/2023.
//

import Foundation

class TrackRowViewModel {
    
    private let track: SpotifyTrack

    init(track: SpotifyTrack) {
        self.track = track
    }
    
    var nameString: String {
        track.name
    }
    
    var artistsString: String {
        var artistsString: String = ""
        
        for (idx, artist) in track.artists.enumerated() {
            if idx > 0 {
                artistsString.append(", ")
            }
            artistsString.append(artist.name)
        }
        
        return artistsString
    }
    
    var albumString: String {
        track.album.name
    }
}
