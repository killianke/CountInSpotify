//
//  PlaybackViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 17/10/2023.
//

import Foundation

class NowPlayingViewModel: ObservableObject, Identifiable {
    
    @Published var error: Error?
    @Published var playButtonDisabled: Bool = true
    @Published var playButtonData: (title: String, image: String)
    
    private let track: Track
    private let player: PlayerManagerProtocol

    init(track: Track,
         remote: SPTAppRemote,
         player: PlayerManagerProtocol = PlayerManager()) {
        
        self.track = track
        self.player = player
        
        player.setRemote(remote)
        player.playTrack(track)
        playButtonData = ("Pause", "pause")
        
        player.isCountingInPublisher.assign(to: &$playButtonDisabled)
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
