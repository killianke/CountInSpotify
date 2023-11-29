//
//  MockPlayerManager.swift
//  CountInSpotifyTests
//
//  Created by Killian-Kenny on 29/11/2023.
//

import Foundation
@testable import CountInSpotify

class MockPlayerManager: PlayerManagerProtocol {
    
    @Published var isCountingIn: Bool = false

    var remote: SPTAppRemote?
    var currentlyPlayingTrack: Track?
    var limitedPlayDuration: TimeInterval?
    var isPaused: Bool = false

    func setRemote(_ remote: SPTAppRemote) {
        self.remote = remote
    }
    
    func playTrack(_ track: CountInSpotify.Track, for duration: TimeInterval?) {
        self.currentlyPlayingTrack = track
        self.limitedPlayDuration = duration
    }
    
    func pause() {
        isPaused = true
    }
    
    func resume() {
        isPaused = false
    }
    
    var isCountingInPublisher: Published<Bool>.Publisher {
        return $isCountingIn
    }
}
