//
//  MockUrlOpeningHandler.swift
//  CountInSpotifyTests
//
//  Created by Killian-Kenny on 03/01/2024.
//

import Foundation
@testable import CountInSpotify

class MockUrlOpeningHandler: URLOpening {
    var shouldReturnCanOpen: Bool = true
    var urlOpened: URL?
    
    func canOpenURL(_ url: URL) -> Bool {
        return shouldReturnCanOpen
    }
    
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?) {
        urlOpened = url
    }
}
