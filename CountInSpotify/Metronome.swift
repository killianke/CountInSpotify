//
//  Metronome.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 29/09/2023.
//

import Foundation
import AVFoundation

class Metronome {
    
    private var engine = AVAudioEngine()
    private var player = AVAudioPlayerNode()
    
    private let fileName1 = "sound1.wav"
    private let fileName2 = "sound2.wav"
    private var file1: AVAudioFile! = nil
    private var file2: AVAudioFile! = nil
    private var buffer1: AVAudioPCMBuffer! = nil
    private var buffer2: AVAudioPCMBuffer! = nil
    
    private let sampleRate: Double = 44100
    
    private var bpm: Double = 120
    private var maxBar: Int?
    private var periodLengthInSamples: Double {
        60.0 / bpm * sampleRate
    }
    private var timerEventCounter: Int = 1
    private var currentBeat: Int = 1
    private var timer: Timer! = nil
    
    private enum MetronomeState {case running; case stopped}
    private var state: MetronomeState = .stopped
    
    init() {
        setupAudio()
    }
    
    //MARK: Public interface
    
    func start(forBars numberOfBars: Int? = nil) {
        self.maxBar = numberOfBars
        
        state = .running
        scheduleFirstBuffer()
        createTimer()
    }
    
    func stop() {
        state = .stopped
        timer.invalidate()
        timerEventCounter = 1
        currentBeat = 1
    }

    //MARK: Private funcs
    
    private func setupAudio() {
        
        let path1 = Bundle.main.path(forResource: fileName1, ofType: nil)!
        let url1 = URL(fileURLWithPath: path1)
        do {
            file1 = try AVAudioFile(forReading: url1)
            buffer1 = AVAudioPCMBuffer(
                pcmFormat: file1.processingFormat,
                frameCapacity: AVAudioFrameCount(periodLengthInSamples))
            try file1.read(into: buffer1!)
            buffer1.frameLength = AVAudioFrameCount(periodLengthInSamples)
        } catch {
            print("Error loading buffer1 \(error)")
        }
        
        let path2 = Bundle.main.path(forResource: fileName2, ofType: nil)!
        let url2 = URL(fileURLWithPath: path2)
        do {
            file2 = try AVAudioFile(forReading: url2)
            buffer2 = AVAudioPCMBuffer(
                pcmFormat: file2.processingFormat,
                frameCapacity: AVAudioFrameCount(periodLengthInSamples))
            try file2.read(into: buffer2!)
            buffer2.frameLength = AVAudioFrameCount(periodLengthInSamples)
        } catch {
            print("Error loading buffer2 \(error)")
        }
        
        // MARK: Configure + start engine
        engine.attach(player)
        engine.connect(player, to: engine.mainMixerNode, format: file1.processingFormat)
        engine.prepare()
        do { try engine.start() } catch { print(error) }
    }
        
    private func createTimer() {
        
        // Compute interval for 2 events per period and set up timer
        let timerIntervallInSamples = 0.5 * self.periodLengthInSamples / sampleRate
        
        timer = Timer.scheduledTimer(withTimeInterval: timerIntervallInSamples, repeats: true) { timer in

            // Schedule next buffer at 1st, 3rd, 5th & 7th timerEvent
            switch self.timerEventCounter {
            case 7:
                // Schedule beat 1 sound
                self.player.scheduleBuffer(self.buffer1, at:nil, options: [], completionHandler: nil)
                
            case 1, 3, 5:
                // Schedule subdivision sound
                self.player.scheduleBuffer(self.buffer2, at:nil, options: [], completionHandler: nil)
            default:
                break
            }
            
            // Display current beat & increase currentBeat (1...4) at 2nd, 4th, 6th & 8th timerEvent
            if self.timerEventCounter % 2 == 0 {
                self.currentBeat += 1
                if self.currentBeat > 4 {
                    self.currentBeat = 1
                }
            }
            
            // Increase timerEventCounter, two events per beat.
            self.timerEventCounter += 1; if self.timerEventCounter > 8 {self.timerEventCounter = 1}
        }
    }
    
    private func scheduleFirstBuffer() {
        player.stop()
        
        // Pre-load main sound for beat "1" before trigger starts
        player.scheduleBuffer(buffer1, at: nil, options: [], completionHandler: nil)
        player.play()
    }
}
