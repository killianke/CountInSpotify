//
//  TracksStore.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 06/10/2023.
//

import Foundation

final class TrackStore: ObservableObject {
    
    @Published var tracks: [Track] = []
    @Published var error: Error?
    
    private let storage = CodableStorage(storage: DiskStorage())
    private let storageKey = "tracks-storage"
    
    func addTrack(_ track: Track) {
        tracks.append(track)
    }
    
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
