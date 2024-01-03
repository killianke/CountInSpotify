//
//  NetworkingFactory.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 03/01/2024.
//

import Foundation

final class NetworkingFactory {
    
    static func createSpotifyService() -> SpotifyServiceable {
        #if targetEnvironment(simulator)
        return MockSpotifyService()
        #else
        return SpotifyService()
        #endif
    }
}
