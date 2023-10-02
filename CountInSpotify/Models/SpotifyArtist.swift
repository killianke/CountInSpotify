//
//  SpotifyArtist.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 01/10/2023.
//

import Foundation

struct SpotifyArtist: Codable {
    var id: String
    var name: String
    var uri: String
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
