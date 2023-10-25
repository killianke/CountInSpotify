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
        ZStack {
            Style.backgroundGradient
            if viewModel.searchTracks.count > 0 {
                list(with: viewModel.searchTracks, headerText: "Search Results")
            } else if viewModel.recentTracks.count > 0 {
                list(with: viewModel.recentTracks, headerText: "Recently Played")
            } else {
                Color.clear
            }
        }
        .navigationTitle("Add Songs")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.teal, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .task {
            await viewModel.fetchTopTracks()
        }
        .searchable(text: $viewModel.searchTerm, prompt: "Search songs")
        .onSubmit(of: .search) {
            Task {
                await viewModel.performSearch()
            }
        }
        .errorAlert(error: $viewModel.error)
    }
    
    private func list(with items: [Track], headerText: String) -> some View {
        List {
            Section {
                ForEach(items) { track in
                    NavigationLink<TrackRowView, TrackDetailsView> {
                        TrackDetailsView(viewModel: TrackDetailsViewModel(track: track), path: $path)
                    } label: {
                        TrackRowView(viewModel: TrackRowViewModel(track: track))
                    }
                }
            } header: {
                Text(headerText).foregroundColor(.white)
            }
        }
    }
}

struct AddTrackView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrackView(path: .constant(NavigationPath()))
    }
}
