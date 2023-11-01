//
//  SpotifyEndpoints.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/10/2023.
//

import Foundation

enum SpotifyEndpoint {
    case topTracks(timeRange: TopTracksTimeRange?)
    case search(query: String, offset: Int, limit: Int)
    case audioAnalysis(trackID: String)
    
    enum TopTracksTimeRange: String {
        case shortTerm = "short_term"
        case mediumTerm = "medium_term"
        case longTerm = "long_term"
    }
}

extension SpotifyEndpoint: Endpoint {
    
    var host: String {
        return "api.spotify.com"
    }
    
    var path: String {
        switch self {
        case .topTracks:
            return "/v1/me/top/tracks"
        case .search:
            return "/v1/search"
        case .audioAnalysis(trackID: let trackID):
            return "/v1/audio-analysis/\(trackID)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .topTracks,
                .search,
                .audioAnalysis(trackID: _):
            return .get
        }
    }

    var header: [String: String]? {
        // Access Token to use in Bearer header
        guard let accessToken = UserDefaults.standard.spotifyToken else {
            return nil
        }
        return [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json;charset=utf-8"
        ]
    }
    
    var queries: [URLQueryItem]? {
        switch self {
        case .search(let query, let offset, let limit):
            return [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "offset", value: "\(offset)"),
                URLQueryItem(name: "type", value: "track")
            ]
        case .topTracks(let timeRange):
            guard let range = timeRange else {
                return nil
            }
            return [
                URLQueryItem(name: "time_range", value: range.rawValue),
            ]
        default:
            return nil
        }
    }
    
    var body: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}
