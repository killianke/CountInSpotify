//
//  TrackDetailsViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 06/10/2023.
//

import Foundation
import SpotifyiOS

class TrackDetailsViewModel: NSObject, ObservableObject, SPTAppRemoteDelegate {
    
    @Published var error: Error?
    @Published var userInteractionDisabled: Bool = true
    @Published var bpmString: String = ""
    @Published var startTimeString: String = "00:00.00"
    @Published var sampleProgress: Double = 0.0
    @Published var trackStartTime: Double = 0 {
        didSet {
            updateStartTimeString(with: trackStartTime)
            track.startTime = trackStartTime
        }
    }
    
    private var track: Track
    private var store: TrackStoreProtocol!
    private var spotifyRemote: SPTAppRemote?
    private var progressTimer: Timer?
    
    private lazy var numberFormatter = NumberFormatter()
    private lazy var timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    private let service = SpotifyService()
    private let player = PlayerManager()
    private let bpmIncrement: Double = 0.1
    private let lowerBPMLimit: Double = 30
    private let upperBPMLimit: Double = 300
    private let startTimeIncrement: Double = 0.1
    private let sampleDuration: TimeInterval = 15.0

    init(track: Track) {
        self.track = track
        super.init()
        fetchTrackInfo()
        SpotifyConnectionManager.shared.remoteDelegate = self
        player.setRemote(SpotifyConnectionManager.shared.remote)
    }
    
    //MARK: Computed properties
    
    var trackInfoViewModel: TrackInfoViewModel {
        TrackInfoViewModel(track: track)
    }
    
    var sliderRange: ClosedRange<Double> {
        let trackLengthSeconds = Double((track.durationInMs ?? 0) / 1000)
        let start = 0.0
        let end = max(trackLengthSeconds, 0)
        
        return start...end
    }
    
    var sliderStep: Double {
        return startTimeIncrement
    }
    
    //MARK: Public interface
    
    func setTrackStore(_ store: TrackStoreProtocol) {
        self.store = store
    }
    
    func didTapAddTrack() {
        store.addTrack(track)
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
        let incrementedTime = trackStartTime + startTimeIncrement
        updateStartTime(to: incrementedTime.round(nearest: startTimeIncrement))
    }

    func decrementStartTime() {
        let decrementedTime = trackStartTime - startTimeIncrement
        if trackStartTime > startTimeIncrement {
            updateStartTime(to: decrementedTime.round(nearest: startTimeIncrement))
        }
    }
    
    func playSample() {
        guard track.bpm != nil else {
            return
        }
        
        player.playTrack(track, for: sampleDuration)
        sampleProgress = 0
        progressTimer?.invalidate()
        
        let timeInterval = 0.1
        let progressInterval = 1 / (sampleDuration / timeInterval)
        progressTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            self.sampleProgress += progressInterval
            if self.sampleProgress >= 1 {
                self.sampleProgress = 0
                timer.invalidate()
            }
        }
    }
    
    //MARK: Private funcs

    private func fetchTrackInfo() {
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

    private func updateBPM(to value: Double) {
        track.bpm = value
        
        numberFormatter.maximumIntegerDigits = 10
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1

        if let formattedBpm = numberFormatter.string(for: value) {
            bpmString = formattedBpm
        }
    }
    
    private func updateStartTime(to value: Double) {
        trackStartTime = value
    }
    
    private func updateStartTimeString(with value: Double) -> Void {
        numberFormatter.maximumIntegerDigits = 0
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        guard let formattedTime = timeFormatter.string(from: value),
                let decimal = numberFormatter.string(for: value) else {
            return
        }
        startTimeString = formattedTime + decimal
    }
    
    //MARK: SPTAppRemoteDelegate

    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.spotifyRemote = appRemote
        player.setRemote(appRemote)
    }

    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        self.error = error
    }

    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        self.error = error
    }
}

private extension Double {
    func round(nearest: Double) -> Double {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
}
