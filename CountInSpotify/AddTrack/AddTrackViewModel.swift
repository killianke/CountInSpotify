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
            tracks = []
        }
    }
    @Published var tracks: [Track] = []
    @Published var error: Error?
    
    private var offset = 0

    private let limit = 20
    private let service = SpotifyService()
    
    func performSearch() async {
        let searchResult = await service.searchTracks(with: searchTerm,
                                                      offset: offset,
                                                      limit: limit)
        switch searchResult {
        case .success(let result):
            DispatchQueue.main.async {
                self.tracks = result.tracks?.items ?? []
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.error = error
            }
        }
    }
}
