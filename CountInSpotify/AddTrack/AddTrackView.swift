//
//  SearchTrackView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 03/10/2023.
//

import SwiftUI

struct AddTrackView: View {
    
    @StateObject var viewModel = AddTrackViewModel()
    
    var body: some View {
        Group {
            List(viewModel.tracks) { track in
                Text(track.name ?? "")
            }
        }
        .navigationTitle("Add Songs")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchTerm, prompt: "Search songs")
        .onSubmit(of: .search) {
            Task {
                await viewModel.performSearch()
            }
        }
    }
}

struct AddTrackView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrackView()
    }
}
