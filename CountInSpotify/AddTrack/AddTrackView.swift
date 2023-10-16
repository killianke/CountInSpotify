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
            if viewModel.tracks.count == 0 {
                Color.clear
            } else {
                List(viewModel.tracks) { track in
                    NavigationLink<TrackRowView, TrackDetailsView> {
                        TrackDetailsView(viewModel: TrackDetailsViewModel(track: track), path: $path)
                    } label: {
                        TrackRowView(viewModel: TrackRowViewModel(track: track))
                    }
                }
            }
        }
        .navigationTitle("Add Songs")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.teal, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .searchable(text: $viewModel.searchTerm, prompt: "Search songs")
        .onSubmit(of: .search) {
            Task {
                await viewModel.performSearch()
            }
        }
        .errorAlert(error: $viewModel.error)
    }
}

struct AddTrackView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrackView(path: .constant(NavigationPath()))
    }
}
