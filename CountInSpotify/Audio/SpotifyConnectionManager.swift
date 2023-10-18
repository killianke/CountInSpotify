//
//  SpotifyRemoteManager.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 27/09/2023.
//

import Foundation
import SpotifyiOS

final class SpotifyConnectionManager: NSObject, SPTAppRemoteDelegate {
    
    static let shared = SpotifyConnectionManager()
    
    let remote: SPTAppRemote = {
        let configuration = SPTConfiguration(clientID: Constants.spotifyClientID, redirectURL: Constants.spotifyRedirectURL)
        return SPTAppRemote(configuration: configuration, logLevel: .debug)
    }()
    private let maxAuthRetryCount = 1

    weak var remoteDelegate: SPTAppRemoteDelegate?
    private var authRetryCount = 0
    
    private override init() {
        super.init()
        remote.connectionParameters.accessToken = UserDefaults.standard.spotifyToken
        remote.delegate = self
    }
    
    func handleSceneDidBecomeActive(_ scene: UIScene) {
        SPTAppRemote.checkIfSpotifyAppIsActive { isActive in
            if isActive {
                self.remote.connect()
            } else {
                self.remote.authorizeAndPlayURI(Constants.spotifySilentTrackId)
            }
        }
    }
    
    func handleSceneWillResignActive(_ scene: UIScene) {
        remote.playerAPI?.setRepeatMode(.off)
        remote.disconnect()
    }
    
    func handleUrl(_ url: URL) -> Bool {
        let parameters = remote.authorizationParameters(from: url);

        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            remote.connectionParameters.accessToken = accessToken
            UserDefaults.standard.spotifyToken = accessToken
            return true
        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            // Show the error
            print("Error: \(error_description)")
            return true
        }
        return false
    }

    //MARK: - SPTAppRemoteDelegate
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("SpotifyConnectionManager: Connected")
        remoteDelegate?.appRemoteDidEstablishConnection(appRemote)
        appRemote.playerAPI?.setRepeatMode(.track) //Repeat silent track
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("SpotifyConnectionManager: Disconnected")
        remoteDelegate?.appRemote(appRemote, didDisconnectWithError: error)
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        if let err = error as? NSError, err.code == Constants.spotifyAuthErrorCode, authRetryCount < maxAuthRetryCount {
            //Retry authentication
            authRetryCount += 1
            self.remote.authorizeAndPlayURI(Constants.spotifySilentTrackId)
        } else {
            remoteDelegate?.appRemote(appRemote, didFailConnectionAttemptWithError: error)
        }
    }
}
