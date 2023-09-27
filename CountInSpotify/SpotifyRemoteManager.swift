//
//  SpotifyRemoteManager.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 27/09/2023.
//

import Foundation

final class SpotifyRemoteManager: NSObject, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
    
    static let shared = SpotifyRemoteManager()
    
    private let remote: SPTAppRemote = {
        let configuration = SPTConfiguration(clientID: Constants.spotifyClientID, redirectURL: Constants.spotifyRedirectURL)
        return SPTAppRemote(configuration: configuration, logLevel: .debug)
    }()
    private let maxAuthRetryCount = 1

    weak var connectionDelegate: SPTAppRemoteDelegate?
    var player: SPTAppRemotePlayerAPI? {
        return remote.playerAPI
    }
    
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
                self.remote.authorizeAndPlayURI("spotify:track:4nFNJmjfgBF7jwv2oBC45b")
            }
        }
    }
    
    func handleSceneWillResignActive(_ scene: UIScene) {
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
        print("connected")
        connectionDelegate?.appRemoteDidEstablishConnection(appRemote)
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected")
        connectionDelegate?.appRemote(appRemote, didDisconnectWithError: error)
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        if let err = error as? NSError, err.code == Constants.spotifyAuthErrorCode, authRetryCount < maxAuthRetryCount {
            //Retry authentication
            authRetryCount += 1
            self.remote.authorizeAndPlayURI("")
        } else {
            connectionDelegate?.appRemote(appRemote, didFailConnectionAttemptWithError: error)
        }
    }
    
    //MARK: - PTAppRemotePlayerStateDelegate
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        print("player state changed")
    }
}
