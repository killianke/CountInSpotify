//
//  TrackListView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/10/2023.
//

import SwiftUI

struct TrackListView: View {
    
    let viewModel = TrackListViewModel()
    var tracks: [SpotifyTrack]
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("My Songs")
                .toolbar {
                    Button("Add") {
                        print("Add Song Tapped")
                    }
                }
        }
    }
    
    @ViewBuilder var content: some View {
        if tracks.isEmpty {
            emptyStateView
        } else {
            listView
        }
    }
    
    var listView: some View {
        List(tracks) { track in
            TrackRow(viewModel: viewModel, track: track)
        }
    }
    
    var emptyStateView: some View {
        VStack(spacing: 50) {
            Text("Nothing to display!").font(.title)
            Button {
                print("Add Song Tapped")
            } label: {
                Text("Add Songs!").font(.headline)
            }            
        }
    }
}

struct TrackListView_Previews: PreviewProvider {
    
    static var previews: some View {
        TrackListView(tracks: [SpotifyTrack.previewContent])
    }
}

struct TrackRow: View {
    
    let viewModel: TrackListViewModel
    var track: SpotifyTrack
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(track.name ?? "Unknown").font(.headline)
            Text(viewModel.getArtistsString(for: track)).font(.caption)
            Text(track.album?.name ?? "Unknown").font(.caption2)
        }
    }
}
