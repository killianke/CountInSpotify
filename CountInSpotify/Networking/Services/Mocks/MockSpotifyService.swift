//
//  MockSpotifyService.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/11/2023.
//

import Foundation

struct MockSpotifyService: SpotifyServiceable {
    
    func getTopTracks() async -> Result<TopTracksResponse, RequestError> {
        guard let response = response(of: TopTracksResponse.self, fromFile: "top-tracks-success") else {
            return .failure(.noResponse)
        }
        return .success(response)
    }
    
    func searchTracks(with query: String, offset: Int, limit: Int) async -> Result<SearchResult, RequestError> {
        guard let response = response(of: SearchResult.self, fromFile: "search-success") else {
            return .failure(.noResponse)
        }
        return .success(response)
    }
    
    func getAudioAnalysisForTrack(withId trackId: String) async -> Result<AudioAnalysis, RequestError> {
        guard let response = response(of: AudioAnalysis.self, fromFile: "audio-analysis-success") else {
            return .failure(.noResponse)
        }
        return .success(response)
    }
        
    private func response<T: Decodable>(of type: T.Type, fromFile fileName: String) -> T? {
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        let data = try! Data(contentsOf: fileUrl)
        return try! JSONDecoder().decode(T.self, from: data)
    }
    
    private func response<T: Decodable>(of type: T.Type, from string: String) -> T {
        let data = string.data(using: .utf8)!
        return try! JSONDecoder().decode(T.self, from: data)
    }
}
