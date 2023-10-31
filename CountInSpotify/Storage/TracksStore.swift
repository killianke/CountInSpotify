//
//  TracksStore.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 06/10/2023.
//

import Foundation
import UIKit

protocol TrackStoreProtocol {
    func addTrack(_ track: Track)
    func updateTrack(_ track: Track)
    func deleteTrack(_ track: Track)
}

final class TrackStore: ObservableObject, TrackStoreProtocol {
    
    @Published var tracks: [Track] = []
    @Published var error: Error?
    
    private let storage = CodableStorage(storage: DiskStorage())
    private let storageKey = "tracks-storage"
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillMoveToBackground),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    func addTrack(_ track: Track) {
        tracks.append(track)
    }
    
    func updateTrack(_ track: Track) {
        if let index = tracks.firstIndex(where: { $0.id == track.id }) {
            tracks[index] = track
        }
    }
    
    func deleteTrack(_ track: Track) {
        if let idx = tracks.firstIndex(of: track) {
            tracks.remove(at: idx)
        }
    }

    @objc private func appWillMoveToBackground() {
        do {
            try storage.save(tracks, for: storageKey)
        } catch let writeError {
            error = writeError
        }
    }
    
    @objc private func appDidBecomeActive() {
        do {
            self.tracks = try storage.fetch(for: storageKey)
        } catch let readError {
            error = readError
        }
    }
}
