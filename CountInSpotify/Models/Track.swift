//
//  SpotifyTrack.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 01/10/2023.
//

import Foundation

struct Track: Codable, Identifiable {
    var album: Album
    var artists: [Artist]
    var durationInMs: Int?
    var id: String
    var name: String
    var uri: String
    var startTime: Int?
    var bpm: Double?
    var metaData: AudioAnalysis?
    
    private enum CodingKeys : String, CodingKey {
        case album
        case artists
        case durationInMs = "duration_ms"
        case id
        case name
        case uri
    }
}

extension Track: Hashable {
    static func == (lhs: Track, rhs: Track) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Track {
    static let previewContent: Self = Track(album: Album.previewContent,
                                            artists: [Artist.previewContent],
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
