//
//  TrackInfoViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 17/10/2023.
//

import Foundation

class TrackInfoViewModel {
    
    private let track: Track

    init(track: Track) {
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
    
    var imageURL: URL? {
        guard let imageObject = track.album.images.first(where: { $0.size == .medium }) else {
            return nil
        }
        return URL(string: imageObject.url)
    }
    
    func spotifyAttributionTapped(urlOpener: URLOpener = URLOpener()) {
        if let url = URL(string: track.uri) {
            urlOpener.open(url: url)
        }
    }
}
