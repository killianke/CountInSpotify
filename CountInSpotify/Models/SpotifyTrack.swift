//
//  SpotifyTrack.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 01/10/2023.
//

import Foundation

struct SpotifyTrack: Codable, Identifiable {
    var album: SpotifyAlbum
    var artists: [SpotifyArtist]
    var durationInMs: Int?
    var id: String
    var name: String
    var uri: String
    var startTime: Int?
    var bpm: Double?
    var metaData: SpotifyAudioAnalysis?
    
    private enum CodingKeys : String, CodingKey {
        case album
        case artists
        case durationInMs = "duration_ms"
        case id
        case name
        case uri
    }
}

extension SpotifyTrack: Hashable {
    static func == (lhs: SpotifyTrack, rhs: SpotifyTrack) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension SpotifyTrack {
    static let previewContent: Self = SpotifyTrack(album: SpotifyAlbum.previewContent,
                                                   artists: [SpotifyArtist.previewContent],
                                                   id: "aa1da4cc",
                                                   name: "Emotion Sickness",
                                                   uri: "spotify:track:0qhGOjVl3uY2N6CAafVmCa")
}

/*
 {
 "album": { See SpotifyAlbum },
 "artists": [{ See SpotifyArtist }],
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
