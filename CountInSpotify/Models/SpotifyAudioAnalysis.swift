//
//  SpotifyTrackAnalysis.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 06/10/2023.
//

import Foundation

struct SpotifyAudioAnalysis: Codable {
    var track: SpotifyAudioAnalysisTrack
    var bars: [SpotifyTrackBar]
    var sections: [SpotifyTrackSection]
    
    var startTime: Int {
        if let section = sections.first(where: { $0.keyConfidence > 0 }) {
            return Int(section.start)
        } else {
            return 0
        }
    }
}

struct SpotifyAudioAnalysisTrack: Codable {
    var tempo: Double
    var timeSignature: Int
    var key: Int
    
    private enum CodingKeys: String, CodingKey {
        case tempo = "tempo"
        case timeSignature = "time_signature"
        case key = "key"
    }
}

struct SpotifyTrackSection: Codable {
    var start: Double
    var duration: Double
    var confidence: Double
    var keyConfidence: Double
    
    private enum CodingKeys: String, CodingKey {
        case start = "start"
        case duration = "duration"
        case confidence = "confidence"
        case keyConfidence = "key_confidence"
    }
}

struct SpotifyTrackBar: Codable {
    var start: Double
    var duration: Double
    var confidence: Double
}

/*
{
  "meta": {
    "analyzer_version": "4.0.0",
    "platform": "Linux",
    "detailed_status": "OK",
    "status_code": 0,
    "timestamp": 1495193577,
    "analysis_time": 6.93906,
    "input_process": "libvorbisfile L+R 44100->22050"
  },
  "track": {
    "num_samples": 4585515,
    "duration": 207.95985,
    "sample_md5": "string",
    "offset_seconds": 0,
    "window_seconds": 0,
    "analysis_sample_rate": 22050,
    "analysis_channels": 1,
    "end_of_fade_in": 0,
    "start_of_fade_out": 201.13705,
    "loudness": -5.883,
    "tempo": 118.211,
    "tempo_confidence": 0.73,
    "time_signature": 4,
    "time_signature_confidence": 0.994,
    "key": 9,
    "key_confidence": 0.408,
    "mode": 0,
    "mode_confidence": 0.485,
    "codestring": "string",
    "code_version": 3.15,
    "echoprintstring": "string",
    "echoprint_version": 4.15,
    "synchstring": "string",
    "synch_version": 1,
    "rhythmstring": "string",
    "rhythm_version": 1
  },
  "bars": [
    {
      "start": 0.49567,
      "duration": 2.18749,
      "confidence": 0.925
    }
  ],
  "beats": [
    {
      "start": 0.49567,
      "duration": 2.18749,
      "confidence": 0.925
    }
  ],
  "sections": [
    {
      "start": 0,
      "duration": 6.97092,
      "confidence": 1,
      "loudness": -14.938,
      "tempo": 113.178,
      "tempo_confidence": 0.647,
      "key": 9,
      "key_confidence": 0.297,
      "mode": -1,
      "mode_confidence": 0.471,
      "time_signature": 4,
      "time_signature_confidence": 1
    }
  ],
  "segments": [
    {
      "start": 0.70154,
      "duration": 0.19891,
      "confidence": 0.435,
      "loudness_start": -23.053,
      "loudness_max": -14.25,
      "loudness_max_time": 0.07305,
      "loudness_end": 0,
      "pitches": [
        0.212,
        0.141,
        0.294
      ],
      "timbre": [
        42.115,
        64.373,
        -0.233
      ]
    }
  ],
  "tatums": [
    {
      "start": 0.49567,
      "duration": 2.18749,
      "confidence": 0.925
    }
  ]
}
*/
