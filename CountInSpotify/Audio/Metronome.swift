//
//  Metronome.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 29/09/2023.
//

import Foundation
import AVFoundation

class Metronome {
    
    var didStopClosure: (()->())?
    
    private var engine = AVAudioEngine()
    private var player = AVAudioPlayerNode()
    
    private let fileName1 = "sound1.wav"
    private let fileName2 = "sound2.wav"
    private var buffer1: AVAudioPCMBuffer!
    private var buffer2: AVAudioPCMBuffer!
    
    private let sampleRate: Double = 44100
    
    private var bpm: Double = 120
    private var periodLength: Double {
        60.0 / bpm
    }
    private var timerEventCounter: Int = 1
    private var currentBeat: Int = 1
    private var currentBar: Int = 1
    private var timer: Timer! = nil
    private var maxBars: Int?
    
    private enum MetronomeState { case running; case stopped }
    private var state: MetronomeState = .stopped
    
    init(bpm: Double) {
        self.bpm = bpm
        setupAudio()
    }
    
    //MARK: Public interface
    
    func start(forBars numberOfBars: Int? = nil) {
        maxBars = numberOfBars

        state = .running
        scheduleFirstBuffer()
        createTimer()
    }
    
    func stop() {
        state = .stopped
        timer.invalidate()
        timerEventCounter = 1
        currentBeat = 1
        currentBar = 1
        
        didStopClosure?()
    }
    
    //MARK: Private funcs
    
    private func setupAudio() {
        guard let audioFile1 = createAudioFile(fileName: fileName1) else {
            return
        }
        buffer1 = createBuffer(withFile: audioFile1)
        
        guard let audioFile2 = createAudioFile(fileName: fileName2) else {
            return
        }
        buffer2 = createBuffer(withFile: audioFile2)
        
        // MARK: Configure + start engine
        engine.attach(player)
        engine.connect(player, to: engine.mainMixerNode, format: audioFile1.processingFormat)
        engine.prepare()
        do { try engine.start() } catch { print(error) }
    }
    
    private func createAudioFile(fileName: String) -> AVAudioFile? {
        let path = Bundle.main.path(forResource: fileName, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            return try AVAudioFile(forReading: url)
        } catch {
            print("Error creating audio file: \(error)")
        }
        return nil
    }
    
    private func createBuffer(withFile file: AVAudioFile) -> AVAudioPCMBuffer? {
        do {
            let periodLengthInSamples = periodLength * sampleRate
            let buffer = AVAudioPCMBuffer(
                pcmFormat: file.processingFormat,
                frameCapacity: AVAudioFrameCount(periodLengthInSamples))!
            try file.read(into: buffer)
            buffer.frameLength = AVAudioFrameCount(periodLengthInSamples)
            return buffer
        } catch {
            print("Error loading buffer: \(error)")
        }
        return nil
    }
    
    private func createTimer() {
        
        // Compute interval for 2 events per period and set up timer
        let timerIntervallInSamples = 0.5 * self.periodLength
        
        timer = Timer.scheduledTimer(withTimeInterval: timerIntervallInSamples, repeats: true) { timer in
            
            // Schedule next buffer at 1st, 3rd, 5th & 7th timerEvent
            switch self.timerEventCounter {
            case 7:
                // Schedule beat 1 sound
                self.player.scheduleBuffer(self.buffer1, at: nil, options: [], completionHandler: nil)
                
            case 1, 3, 5:
                // Schedule subdivision sound
                self.player.scheduleBuffer(self.buffer2, at: nil, options: [], completionHandler: nil)
            default:
                break
            }
            // Display current beat & increase currentBeat (1...4) at 2nd, 4th, 6th & 8th timerEvent
            if self.timerEventCounter % 2 == 0 {
                self.currentBeat += 1
                if self.currentBeat > 4 {
                    self.currentBar += 1
                    self.currentBeat = 1
                }
            }
            
            // Increase timerEventCounter, two events per beat.
            self.timerEventCounter += 1; if self.timerEventCounter > 8 {self.timerEventCounter = 1}
            
            if self.currentBar == self.maxBars && self.timerEventCounter == 8 {
                self.stop()
            }
        }
    }
    
    private func scheduleFirstBuffer() {
        player.stop()
        
        // Pre-load main sound for beat "1" before trigger starts
        player.scheduleBuffer(buffer1, at: nil, options: [], completionHandler: nil)
        player.play()
    }
}
