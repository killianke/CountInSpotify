//
//  TrackDetailsViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 06/10/2023.
//

import Foundation

class TrackDetailsViewModel: ObservableObject {
    
    @Published var error: Error?
    @Published var userInteractionDisabled: Bool = true
    @Published var bpmString: String = ""
    @Published var startTimeString: String = "00:00"
    
    private(set) var track: Track
    
    private lazy var numberFormatter = NumberFormatter()
    private lazy var timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    private let service = SpotifyService()
    private let bpmIncrement: Double = 0.1
    private let lowerBPMLimit: Double = 30
    private let upperBPMLimit: Double = 300
    private let startTimeIncrement: Double = 0.25

    init(track: Track) {
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
                    self.userInteractionDisabled = false
                    
                    self.updateBPM(to: analysis.track.tempo.round(nearest: self.bpmIncrement))
                    self.updateStartTime(to: 0.0)
                    
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }

    func incrementBPM() {
        if let bpm = track.bpm, bpm < upperBPMLimit {
            updateBPM(to: bpm + bpmIncrement)
        }
    }

    func decrementBPM() {
        if let bpm = track.bpm, bpm > lowerBPMLimit {
            updateBPM(to: bpm - bpmIncrement)
        }
    }
    
    func incrementStartTime() {
        if let startTime = track.startTime {
            updateStartTime(to: startTime + startTimeIncrement)
        }
    }

    func decrementStartTime() {
        if let startTime = track.startTime, startTime > startTimeIncrement {
            updateStartTime(to: startTime - startTimeIncrement)
        }
    }

    private func updateBPM(to value: Double) {
        track.bpm = value
        
        numberFormatter.maximumIntegerDigits = .max
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1

        if let formattedBpm = numberFormatter.string(for: value) {
            bpmString = formattedBpm
        }
    }
    
    private func updateStartTime(to value: Double) {
        numberFormatter.maximumIntegerDigits = 0
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        guard let formattedTime = timeFormatter.string(from: value),
                let decimal = numberFormatter.string(for: value) else {
            return
        }
        startTimeString = formattedTime + decimal
        track.startTime = value
    }
}

private extension Double {
    func round(nearest: Double) -> Double {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
}
