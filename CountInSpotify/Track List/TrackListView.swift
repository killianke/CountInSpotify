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
    
    @State private var path = NavigationPath()
    
    private enum NavigationDestination: Codable {
        case addTrack
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if tracks.isEmpty {
                    emptyStateView
                } else {
                    listView
                }
            }
            .navigationTitle("My Songs")
            .toolbar {
                Button("Add") {
                    path.append(NavigationDestination.addTrack)
                }
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .addTrack: AddTrackView()
                }
            }
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
                path.append(NavigationDestination.addTrack)
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
