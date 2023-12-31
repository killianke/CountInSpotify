//
//  Constants.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 20/09/2023.
//

import Foundation

struct Constants {
    static let spotifyClientID = "841fa0a3ce334667aca0223c99dbe3f2"
    static let spotifyRedirectURL = URL(string: "count-in-spotify-ios://spotify-login-callback")!
    static let spotifyBaseURLScheme = "spotify://"
    static let spotifySilentTrackId = "spotify:track:7p5bQJB4XsZJEEn6Tb7EaL"
    static let spotifyAuthErrorCode = -1000
}
