//
//  SceneDelegate.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 20/09/2023.
//

import UIKit

import SpotifyiOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
    
    let maxAuthRetryCount = 1

    var window: UIWindow?
    var authRetryCount = 0
    
    lazy var spotifyRemote: SPTAppRemote = {
        let configuration = SPTConfiguration(clientID: Constants.spotifyClientID,
                                             redirectURL: Constants.spotifyRedirectURL)
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.connectionParameters.accessToken = UserDefaults.standard.spotifyToken
        appRemote.delegate = self
        return appRemote
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        SPTAppRemote.checkIfSpotifyAppIsActive { isActive in
            if isActive {
                self.spotifyRemote.connect()
            } else {
                self.spotifyRemote.authorizeAndPlayURI("")
            }
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        spotifyRemote.disconnect()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }

        let parameters = spotifyRemote.authorizationParameters(from: url);

        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            spotifyRemote.connectionParameters.accessToken = accessToken
            UserDefaults.standard.spotifyToken = accessToken
        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            // Show the error
            print("Error: \(error_description)")
        }
    }

    //MARK: - SPTAppRemoteDelegate
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("connected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
      print("disconnected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        if let err = error as? NSError, err.code == Constants.spotifyAuthErrorCode, authRetryCount < maxAuthRetryCount {
            //Retry authentication
            authRetryCount += 1
            self.spotifyRemote.authorizeAndPlayURI("")
        }
        print("failed")
    }
    
    //MARK: - PTAppRemotePlayerStateDelegate
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
      print("player state changed")
    }
}

