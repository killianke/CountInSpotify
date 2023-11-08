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
    @Published var countInBarsString: String = ""
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
    private var progressTimer: Timer?
    
    private lazy var numberFormatter = NumberFormatter()
    private lazy var timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    private let editing: Bool
    private let service: SpotifyServiceable
    private let player: PlayerManagerProtocol
    private let maxCountInBars: Int = 4
    private let bpmIncrement: Double = 0.1
    private let lowerBPMLimit: Double = 30
    private let upperBPMLimit: Double = 300
    private let startTimeIncrement: Double = 0.1
    private let sampleDuration: TimeInterval = 10.0

    init(track: Track,
         isEditing: Bool = false,
         player: PlayerManagerProtocol = PlayerManager(),
         service: SpotifyServiceable = SpotifyService()) {
        
        self.editing = isEditing
        self.track = track
        self.player = player
        self.service = service
        
        super.init()
        
        setInitialState(for: track)
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
    
    var actionButtonTitle: String {
        if editing {
            return "Update song settings"
        } else {
            return "Add to my songs"
        }
    }
    
    //MARK: Public interface
    
    func setTrackStore(_ store: TrackStoreProtocol) {
        self.store = store
    }
    
    func didTapActionButton() {
        if editing {
            store.updateTrack(track)
        } else {
            store.addTrack(track)
        }
    }
    
    func incrementBars() {
        let countInBars = track.countInBars
        if countInBars < maxCountInBars {
            updateCountInBars(to: countInBars + 1)
        }
    }

    func decrementBars() {
        let countInBars = track.countInBars
        if countInBars > 1 {
            updateCountInBars(to: countInBars - 1)
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
        
        let countInDuration = getCountInDuration(for: track) ?? 0
        let totalDuration = countInDuration + sampleDuration
        
        player.playTrack(track, for: totalDuration)
        sampleProgress = 0
        progressTimer?.invalidate()
        
        let timeInterval = 0.1
        let progressInterval = 1 / (totalDuration / timeInterval)
        progressTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            self.sampleProgress += progressInterval
            if self.sampleProgress >= 1 {
                self.sampleProgress = 0
                timer.invalidate()
            }
        }
    }
    
    func getCountInDuration(for track: Track) -> TimeInterval? {
        guard let bpm = track.bpm else {
            return nil
        }
        let beatDuration = 60 / bpm
        let barDuration = beatDuration * 4
        let bars = track.countInBars
        return barDuration * Double(bars)
    }
    
    //MARK: Private funcs
    
    private func setInitialState(for track: Track) {
        updateCountInBars(to: track.countInBars)

        if let existingBpm = track.bpm {
            updateBPM(to: existingBpm)
        }
        
        if let existingStartTime = track.startTime {
            updateStartTime(to: existingStartTime)
        }
    }

    private func fetchTrackInfo() {
        Task {
            let result = await service.getAudioAnalysisForTrack(withId: track.id)
            
            await MainActor.run {
                switch result {
                case .success(let analysis):
                    self.userInteractionDisabled = false
                    
                    if self.track.bpm == nil {
                        self.updateBPM(to: analysis.track.tempo.round(nearest: self.bpmIncrement))
                    }
                    if self.track.startTime == nil {
                        self.updateStartTime(to: 0.0)
                    }
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    private func updateCountInBars(to value: Int) {
        track.countInBars = value
        countInBarsString = "\(value)"
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
