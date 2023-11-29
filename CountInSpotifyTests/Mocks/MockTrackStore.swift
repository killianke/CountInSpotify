//
//  MockTrackStore.swift
//  CountInSpotifyTests
//
//  Created by Killian-Kenny on 29/11/2023.
//

import Foundation
import XCTest
@testable import CountInSpotify

class MockTrackStore: TrackStoreProtocol {
    
    var addTrackExpectation: XCTestExpectation?
    var updateTrackExpectation: XCTestExpectation?
    var deleteTrackExpectation: XCTestExpectation?

    func addTrack(_ track: CountInSpotify.Track) {
        addTrackExpectation?.fulfill()
    }
    
    func updateTrack(_ track: CountInSpotify.Track) {
        updateTrackExpectation?.fulfill()
    }
    
    func deleteTrack(_ track: CountInSpotify.Track) {
        deleteTrackExpectation?.fulfill()
    }
}
