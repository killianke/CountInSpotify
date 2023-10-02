//
//  SpotifySearchResult.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/10/2023.
//

import Foundation

struct SpotifySearchResult: Codable {
    var tracks: SpotifySearchResultType<SpotifyTrack>?
    var artists: SpotifySearchResultType<SpotifyArtist>?
    var albums: SpotifySearchResultType<SpotifyAlbum>?
}

struct SpotifySearchResultType<ResultType: Codable>: Codable {
    var limit: Int
    var offset: Int
    var total: Int
    var items: [ResultType]
}
