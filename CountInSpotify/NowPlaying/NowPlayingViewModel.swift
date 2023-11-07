//
//  PlaybackViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 17/10/2023.
//

import Foundation

class NowPlayingViewModel: ObservableObject, Identifiable {
    
    @Published var error: Error?
    @Published var playButtonData: (title: String, image: String)
    
    private let track: Track
    private let player = PlayerManager()

    init(track: Track, remote: SPTAppRemote) {
        self.track = track
        player.setRemote(remote)
        player.playTrack(track)
        playButtonData = ("Pause", "pause")
    }
    
    func restartTapped() {
        player.playTrack(track)
    }
    
    func playToggled() {
        if player.isPaused {
            player.resume()
            playButtonData = ("Pause", "pause")
        } else {
            player.pause()
            playButtonData = ("Play", "play")
        }
    }
    
    //MARK: Computed properties
    
    var trackInfoViewModel: TrackInfoViewModel {
        TrackInfoViewModel(track: track)
    }
}
