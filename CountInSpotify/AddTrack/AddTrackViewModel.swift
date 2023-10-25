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
    @Published var recentTracks: [Track] = []
    @Published var searchTracks: [Track] = []
    @Published var error: Error?
    
    private var offset = 0

    private let limit = 20
    private let service = SpotifyService()
    
    func fetchTopTracks() async {
        let result = await service.getTopTracks()
        
        switch result {
        case .success(let object):
            DispatchQueue.main.async {
                self.recentTracks = object.items
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.error = error
            }
        }
    }
    
    func performSearch() async {
        let searchResult = await service.searchTracks(with: searchTerm,
                                                      offset: offset,
                                                      limit: limit)
        switch searchResult {
        case .success(let result):
            DispatchQueue.main.async {
                self.searchTracks = result.tracks?.items ?? []
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.error = error
            }
        }
    }
}
