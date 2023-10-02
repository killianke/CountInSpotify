//
//  SpotifyService.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/10/2023.
//

import Foundation

protocol SpotifyServiceable {
    func searchTracks(with query: String, offset: Int, limit: Int) async -> Result<SpotifySearchResult, RequestError>
}

struct SpotifyService: HTTPClient, SpotifyServiceable {
    
    func searchTracks(with query: String, offset: Int, limit: Int) async -> Result<SpotifySearchResult, RequestError> {
        return await sendRequest(
            endpoint: SpotifyEndpoint.search(query: query, offset: offset, limit: limit),
            responseModel: SpotifySearchResult.self
        )
    }
}
