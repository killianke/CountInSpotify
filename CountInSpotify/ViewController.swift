//
//  ViewController.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 20/09/2023.
//

import UIKit
import CoreAudioKit

class ViewController: UIViewController, SPTAppRemoteDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        SpotifyRemoteManager.shared.connectionDelegate = self
        
        self.searchSong()
    }
    
    func searchSong() {
        Task {
            let searchResult = await SpotifyService().searchTracks(with: "money for nothing", offset: 0, limit: 20)
            
            switch searchResult {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: SPTAppRemoteDelegate
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        appRemote.playerAPI?.play(Constants.spotifySilentTrackId)
                
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let track = Track(spotifyID: "spotify:track:4nFNJmjfgBF7jwv2oBC45b",
                          startTime: 96800,
                          bpm: 134)

        let metronome = Metronome(bpm: track.bpm)
        
        metronome.didStopClosure = {
            appRemote.playerAPI?.play(track.spotifyID)
            appRemote.playerAPI?.seek(toPosition: track.startTime)
        }
        
        metronome.start(forBars: 1)
    }
        
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        
    }
}
