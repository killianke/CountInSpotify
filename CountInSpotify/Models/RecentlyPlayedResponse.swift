//
//  RecentlyPlayedResponse.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 25/10/2023.
//

import Foundation

struct RecentlyPlayedResponse: Codable {
    var items: [RecentlyPlayedItem]
}

struct RecentlyPlayedItem: Codable {
    var track: Track
    var playedAt: String
    
    private enum CodingKeys : String, CodingKey {
        case track
        case playedAt = "played_at"
    }
}
