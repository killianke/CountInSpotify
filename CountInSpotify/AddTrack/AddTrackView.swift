//
//  SearchTrackView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 03/10/2023.
//

import SwiftUI

struct AddTrackView: View {
    
    @Binding var path: NavigationPath
    @StateObject var viewModel = AddTrackViewModel()
    
    var body: some View {
        List(viewModel.tracks) { track in
            NavigationLink<TrackRowView, TrackDetailsView> {
                TrackDetailsView(path: $path, viewModel: TrackDetailsViewModel(track: track))
            } label: {
                TrackRowView(viewModel: TrackRowViewModel(track: track))
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
        AddTrackView(path: .constant(NavigationPath()))
    }
}
