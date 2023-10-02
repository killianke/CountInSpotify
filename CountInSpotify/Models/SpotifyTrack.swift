//
//  SpotifyTrack.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 01/10/2023.
//

import Foundation

struct SpotifyTrack: Codable {
    var album: SpotifyAlbum?
    var artists: [SpotifyArtist]?
    var durationInMs: Int?
    var id: String?
    var name: String?
    var uri: String?
    var startTime: Int?
    var bpm: Double?
    
    private enum CodingKeys : String, CodingKey {
        case album
        case durationInMs = "duration_ms"
        case id
        case name
        case uri
    }
}

/*
 {
 "album": {},
 "artists": [
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
 ],
 "available_markets": [],
 "disc_number": 1,
 "duration_ms": 207959,
 "explicit": false,
 "external_ids": {
 "isrc": "USUM71703861"
 },
 "external_urls": {
 "spotify": "https://open.spotify.com/track/11dFghVXANMlKmJXsNCbNl"
 },
 "href": "https://api.spotify.com/v1/tracks/11dFghVXANMlKmJXsNCbNl",
 "id": "11dFghVXANMlKmJXsNCbNl",
 "name": "Cut To The Feeling",
 "popularity": 0,
 "preview_url": null,
 "track_number": 1,
 "type": "track",
 "uri": "spotify:track:11dFghVXANMlKmJXsNCbNl",
 "is_local": false
 }
 */
