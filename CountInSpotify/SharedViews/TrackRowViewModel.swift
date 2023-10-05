//
//  TrackRowViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 05/10/2023.
//

import Foundation

class TrackRowViewModel {
    
    func getArtistsString(for track: SpotifyTrack) -> String {
        guard let artists = track.artists else {
            return "Unknown Artist"
        }
        
        var artistsString: String = ""
        
        for (idx, artist) in artists.enumerated() {
            if idx > 0 {
                artistsString.append(", ")
            }
            artistsString.append(artist.name)
        }
        
        return artistsString
    }
}
