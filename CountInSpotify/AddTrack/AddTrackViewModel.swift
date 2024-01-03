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
    @Published var topTracks: [Track] = []
    @Published var searchTracks: [Track] = []
    @Published var error: Error?
    
    private var offset = 0

    private let limit = 20
    private let service: SpotifyServiceable
    
    init(service: SpotifyServiceable) {
        self.service = service
    }
    
    @MainActor
    func fetchTopTracks() async {
        self.loading = true
        let result = await service.getTopTracks()

        switch result {
        case .success(let response):
            self.loading = false
            self.topTracks = response.items
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
    
    func openSpotifyButtonTapped(urlOpener: URLOpener = URLOpener()) {
        if let url = URL(string: Constants.spotifyBaseURLScheme) {
            urlOpener.open(url: url)
        }
    }
}
