//
//  TrackListView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/10/2023.
//

import SwiftUI

struct TrackListView: View {
    
    let viewModel = TrackListViewModel()
    
    @StateObject var trackStore = TrackStore()
    @State private var path = NavigationPath()
    
    private enum NavigationDestination: Hashable {
        case addTrack
        case editTrack(track: Track)
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Style.backgroundGradient
                Group {
                    if trackStore.tracks.isEmpty {
                        emptyStateView
                    } else {
                        listView
                    }
                }
                .navigationTitle("My Songs")
                .toolbar {
                    Button {
                        path.append(NavigationDestination.addTrack)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .navigationDestination(for: NavigationDestination.self) { destination in
                    handleNavigation(for: destination)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .environmentObject(trackStore)
        .onAppear {
            viewModel.setTrackStore(trackStore)
        }
    }
    
    private var listView: some View {
        List(trackStore.tracks) { track in
            TrackRowView(viewModel: TrackRowViewModel(track: track))
                .onTapGesture {
                    viewModel.playTrack(track)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        viewModel.deleteTrack(track)
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                    Button {
                        path.append(NavigationDestination.editTrack(track: track))
                    } label: {
                        Label("Edit", systemImage: "slider.horizontal.3")
                    }
                    .tint(.blue)
                }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 50) {
            Text("Nothing to display!").font(.title)
            Button {
                path.append(NavigationDestination.addTrack)
            } label: {
                Text("Add Songs!").font(.headline)
            }
        }
    }
    
    private func handleNavigation(for destination: NavigationDestination) -> AnyView {
        switch destination {
        case .addTrack:
            return AddTrackView(path: $path).eraseToAnyView()
        case .editTrack(track: let track):
            //TODO: Add edit navigation
            return Text("Edit track: \(track.name)").eraseToAnyView()
        }
    }
}

struct TrackListView_Previews: PreviewProvider {
    
    static var previews: some View {
        TrackListView()
    }
}
