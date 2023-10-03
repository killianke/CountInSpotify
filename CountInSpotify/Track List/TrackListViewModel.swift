//
//  TrackListViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/10/2023.
//

import Foundation

class TrackListViewModel {
    
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
