//
//  AddTrackViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 04/10/2023.
//

import Foundation
import Combine

class AddTrackViewModel: ObservableObject {
    
    @Published var searchTerm: String = "" {
        didSet {
            searchTracks = []
        }
    }
    @Published var loading: Bool = false
    @Published var recentTracks: [Track] = []
    @Published var searchTracks: [Track] = []
    @Published var error: Error?
    
    private var offset = 0

    private let limit = 20
    private let service = SpotifyService()
    
    @MainActor
    func fetchRecentlyPlayedTracks() async {
        self.loading = true
        let result = await service.getRecentTracks()
        
        switch result {
        case .success(let response):
            self.loading = false
            self.recentTracks = response.items.map { $0.track }
        case .failure(let error):
            self.loading = false
            self.error = error
        }
    }
    
    @MainActor
    func performSearch() async {
        self.loading = true
        let searchResult = await service.searchTracks(with: searchTerm,
                                                      offset: offset,
                                                      limit: limit)
        switch searchResult {
        case .success(let result):
            self.loading = false
            self.searchTracks = result.tracks?.items ?? []
        case .failure(let error):
            self.loading = false
            self.error = error
        }
    }
}
