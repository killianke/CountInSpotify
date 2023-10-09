//
//  SpotifyArtist.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 01/10/2023.
//

import Foundation

struct Artist: Codable, Identifiable {
    var id: String
    var name: String
    var uri: String
}

extension Artist {
    static let previewContent: Self = Artist(id: "4252803a",
                                             name: "Queens of the Stone Age",
                                             uri: "4252803a")
}

/*
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/6sFIWsNpZYqfjUpaCgueju"
 },
 "href": "https://api.spotify.com/v1/artists/6sFIWsNpZYqfjUpaCgueju",
 "id": "6sFIWsNpZYqfjUpaCgueju",
 "name": "Carly Rae Jepsen",
 "type": "artist",
 "uri": "spotify:artist:6sFIWsNpZYqfjUpaCgueju"
 }
 */
