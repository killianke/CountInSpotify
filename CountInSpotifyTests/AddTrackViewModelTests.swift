//
//  AddTrackViewModelTests.swift
//  CountInSpotifyTests
//
//  Created by Killian-Kenny on 03/01/2024.
//

import XCTest
@testable import CountInSpotify

final class AddTrackViewModelTests: XCTestCase {
    
    var testSubject: AddTrackViewModel!

    override func setUpWithError() throws {
        testSubject = AddTrackViewModel(service: MockSpotifyService())
        
        XCTAssertNil(testSubject.error)
        XCTAssertFalse(testSubject.loading)
        XCTAssertEqual(testSubject.topTracks.count, 0)
        XCTAssertEqual(testSubject.searchTracks.count, 0)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchTopTracks_Success() async throws {
        XCTAssertFalse(testSubject.loading)
        XCTAssertEqual(testSubject.topTracks.count, 0)
        
        await testSubject.fetchTopTracks()
        
        XCTAssertGreaterThan(testSubject.topTracks.count, 0)
        XCTAssertNil(testSubject.error)
    }
    
    func testFetchTopTracks_Failure() async throws {
        //TODO: Add implementation
    }
    
    func testPerformSearch_Success() async throws {
        XCTAssertFalse(testSubject.loading)
        XCTAssertEqual(testSubject.searchTracks.count, 0)
        
        testSubject.searchTerm = "Hello"
        await testSubject.performSearch()
        
        XCTAssertGreaterThan(testSubject.searchTracks.count, 0)
        XCTAssertNil(testSubject.error)
        
        testSubject.searchTerm = "Goodbye"
        XCTAssertEqual(testSubject.searchTracks.count, 0)
    }
    
    func testPerformSearch_Failure() async throws {
        //TODO: Add implementation
    }

    func testOpenSpotifyButtonTapped() throws {
        let mockHandler = MockUrlOpeningHandler()
        
        XCTAssertNil(mockHandler.urlOpened)
        mockHandler.shouldReturnCanOpen = false
        
        testSubject.openSpotifyButtonTapped(urlOpener: URLOpener(handler: mockHandler))
        
        XCTAssertNil(mockHandler.urlOpened)
        mockHandler.shouldReturnCanOpen = true
        
        testSubject.openSpotifyButtonTapped(urlOpener: URLOpener(handler: mockHandler))
        
        XCTAssertEqual(mockHandler.urlOpened?.absoluteString, Constants.spotifyBaseURLScheme)
    }
}
