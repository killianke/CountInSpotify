//
//  SpotifySearchResult.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/10/2023.
//

import Foundation

struct SearchResult: Codable {
    var tracks: SearchResultType<Track>?
    var artists: SearchResultType<Artist>?
    var albums: SearchResultType<Album>?
}

struct SearchResultType<ResultType: Codable>: Codable {
    var limit: Int
    var offset: Int
    var total: Int
    var items: [ResultType]
}
