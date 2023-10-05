//
//  AddTrackViewModel.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 04/10/2023.
//

import Foundation
import Combine

class AddTrackViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var tracks: [SpotifyTrack] = []
    @Published var error: Error?
    
    private var cancellable: AnyCancellable?
    private var offset = 0

    private let limit = 20
    private let service = SpotifyService()
    
    init() {
        cancellable = $searchTerm.debounce(for: 2, scheduler: DispatchQueue.main).sink { term in
            Task {
                await self.search(using: term)
            }
        }
    }
    
    func search(using query: String) async {
        let searchResult = await service.searchTracks(with: query,
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
