//
//  TrackDetailsViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 06/10/2023.
//

import Foundation

class TrackDetailsViewModel: ObservableObject {
    
    @Published var error: Error?
    @Published var bpmString: String = ""
    
    private let track: SpotifyTrack
    private let service = SpotifyService()
    private lazy var numberFormatter = NumberFormatter()
    
    init(track: SpotifyTrack) {
        self.track = track
        fetchTrackInfo()
    }
    
    var nameString: String {
        track.name
    }
    
    var artistsString: String {
        var artistsString: String = ""
        
        for (idx, artist) in track.artists.enumerated() {
            if idx > 0 {
                artistsString.append(", ")
            }
            artistsString.append(artist.name)
        }
        
        return artistsString
    }
    
    var albumString: String {
        track.album.name
    }
    
    var imageURL: URL? {
        guard let imageObject = track.album.images.first(where: { $0.size == .medium }) else {
            return nil
        }
        return URL(string: imageObject.url)
    }
    
    func fetchTrackInfo() {
        Task {
            let result = await service.getAudioAnalysisForTrack(withId: track.id)
            
            DispatchQueue.main.async {
                switch result {
                case .success(let analysis):
                    if let formattedBpm = self.numberFormatter.string(for: analysis.track.tempo) {
                        self.bpmString = formattedBpm
                    }
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
}
