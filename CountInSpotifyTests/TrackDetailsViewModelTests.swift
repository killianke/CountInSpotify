//
//  TrackDetailsViewModelTests.swift
//  CountInSpotifyTests
//
//  Created by Killian-Kenny on 29/11/2023.
//

import XCTest
@testable import CountInSpotify

final class TrackDetailsViewModelTests: XCTestCase {
    
    var testSubject: TrackDetailsViewModel!
    
    override func setUpWithError() throws {
        testSubject = TrackDetailsViewModel(
            track: Track.previewContent,
            isEditing: false,
            player: MockPlayerManager(),
            service: MockSpotifyService()
        )
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSliderRange() throws {
        XCTAssertEqual(testSubject.sliderRange, 0...60)
    }
        
    func testDidTapActionButton() throws {
        let mockTrackStore = MockTrackStore()
        testSubject.setTrackStore(mockTrackStore)
        
        let addTrackExp = expectation(description: "Add track to store")
        mockTrackStore.addTrackExpectation = addTrackExp
        
        testSubject.didTapActionButton()

        waitForExpectations(timeout: 2.0)
    }
    
    func testIncrementBars() throws {
        var sampleTrack = Track.previewContent
        sampleTrack.countInBars = 2
        
        testSubject = TrackDetailsViewModel(
            track: sampleTrack,
            isEditing: false,
            player: MockPlayerManager(),
            service: MockSpotifyService()
        )
        
        testSubject.incrementBars()
        XCTAssertEqual(testSubject.track.countInBars, 3)
        
        testSubject.incrementBars()
        XCTAssertEqual(testSubject.track.countInBars, 4)
        
        testSubject.incrementBars()
        XCTAssertEqual(testSubject.track.countInBars, 4)
    }
    
    func testDecrementBars() throws {
        var sampleTrack = Track.previewContent
        sampleTrack.countInBars = 3
        
        testSubject = TrackDetailsViewModel(
            track: sampleTrack,
            isEditing: false,
            player: MockPlayerManager(),
            service: MockSpotifyService()
        )
        
        testSubject.decrementBars()
        XCTAssertEqual(testSubject.track.countInBars, 2)
        
        testSubject.decrementBars()
        XCTAssertEqual(testSubject.track.countInBars, 1)
        
        testSubject.decrementBars()
        XCTAssertEqual(testSubject.track.countInBars, 1)
    }
    
    func testIncrementBPM() throws {
        var sampleTrack = Track.previewContent
        sampleTrack.bpm = 299.8
        
        testSubject = TrackDetailsViewModel(
            track: sampleTrack,
            isEditing: false,
            player: MockPlayerManager(),
            service: MockSpotifyService()
        )
        
        testSubject.incrementBPM()
        XCTAssertEqual(testSubject.track.bpm, 299.9)
        
        testSubject.incrementBPM()
        XCTAssertEqual(testSubject.track.bpm, 300)
        
        testSubject.incrementBPM()
        XCTAssertEqual(testSubject.track.bpm, 300)
    }
    
    func testDecrementBPM() throws {
        var sampleTrack = Track.previewContent
        sampleTrack.bpm = 30.2
        
        testSubject = TrackDetailsViewModel(
            track: sampleTrack,
            isEditing: false,
            player: MockPlayerManager(),
            service: MockSpotifyService()
        )
        
        testSubject.decrementBPM()
        XCTAssertEqual(testSubject.track.bpm, 30.1)
        
        testSubject.decrementBPM()
        XCTAssertEqual(testSubject.track.bpm, 30)
        
        testSubject.decrementBPM()
        XCTAssertEqual(testSubject.track.bpm, 30)
    }
    
    func testIncrementStartTime() throws {
        XCTAssertNil(testSubject.track.startTime)
        
        testSubject.incrementStartTime()
        XCTAssertEqual(testSubject.track.startTime, 0.1)
        
        testSubject.incrementStartTime()
        XCTAssertEqual(testSubject.track.startTime, 0.2)

        testSubject.incrementStartTime()
        XCTAssertEqual(testSubject.track.startTime, 0.3)
    }
    
    func testDecrementStartTime() throws {
        var sampleTrack = Track.previewContent
        sampleTrack.startTime = 0.2
        
        testSubject = TrackDetailsViewModel(
            track: sampleTrack,
            isEditing: false,
            player: MockPlayerManager(),
            service: MockSpotifyService()
        )
        
        XCTAssertEqual(testSubject.track.startTime, 0.2)

        testSubject.decrementStartTime()
        XCTAssertEqual(testSubject.track.startTime, 0.1)
        
        testSubject.decrementStartTime()
        XCTAssertEqual(testSubject.track.startTime, 0.0)

        testSubject.decrementStartTime()
        XCTAssertEqual(testSubject.track.startTime, 0.0)
    }
    
    func testPlaySample() throws {
        let mockPlayer = MockPlayerManager()

        var track = Track.previewContent
        track.bpm = 60

        testSubject = TrackDetailsViewModel(
            track: track,
            isEditing: false,
            player: mockPlayer,
            service: MockSpotifyService()
        )
        
        XCTAssertNil(mockPlayer.currentlyPlayingTrack)
        
        testSubject.playSample()
        
        XCTAssertNotNil(mockPlayer.currentlyPlayingTrack)
        XCTAssertEqual(mockPlayer.currentlyPlayingTrack?.id, track.id)
        XCTAssertEqual(mockPlayer.limitedPlayDuration, 14)
    }
    
    func testGetCountInDuration() throws {

        var sampleTrack = Track.previewContent
        sampleTrack.bpm = 60
        sampleTrack.countInBars = 1
        
        XCTAssertEqual(testSubject.getCountInDuration(for: sampleTrack), 4)
        
        sampleTrack.countInBars = 2
        
        XCTAssertEqual(testSubject.getCountInDuration(for: sampleTrack), 8)
        
        sampleTrack.bpm = 100
        
        XCTAssertEqual(testSubject.getCountInDuration(for: sampleTrack), 4.8)
    }
}
