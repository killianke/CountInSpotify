//
//  SpotifyService.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/10/2023.
//

import Foundation

protocol SpotifyServiceable {
    func searchTracks(with query: String, offset: Int, limit: Int) async -> Result<SpotifySearchResult, RequestError>
    func getAudioAnalysisForTrack(withId trackId: String) async -> Result<SpotifyAudioAnalysis, RequestError>
}

struct SpotifyService: HTTPClient, SpotifyServiceable {
    
    func searchTracks(with query: String, offset: Int, limit: Int) async -> Result<SpotifySearchResult, RequestError> {
        return await sendRequest(
            endpoint: SpotifyEndpoint.search(query: query, offset: offset, limit: limit),
            responseModel: SpotifySearchResult.self
        )
    }
    
    func getAudioAnalysisForTrack(withId trackId: String) async -> Result<SpotifyAudioAnalysis, RequestError> {
        return await sendRequest(
            endpoint: SpotifyEndpoint.audioAnalysis(trackID: trackId),
            responseModel: SpotifyAudioAnalysis.self
        )
    }
}
