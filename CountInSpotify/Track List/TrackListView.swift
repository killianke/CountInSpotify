//
//  TrackListView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/10/2023.
//

import SwiftUI

struct TrackListView: View {
    
    @StateObject var viewModel = TrackListViewModel()
    @StateObject var trackStore = TrackStore()
    @State private var path = NavigationPath()
    
    private enum NavigationDestination: Hashable {
        case addTrack
        case editTrack(track: Track)
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                BackgroundGradientView()

                Group {
                    if shouldShowEmptyState {
                        emptyStateView
                    } else {
                        listView
                    }
                }
                .navigationTitle("Songs")
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(Style.Colors.accentColor, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
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
                
                if trackStore.fetching {
                    LoadingIndicatorView()
                }
            }
        }
        .accentColor(.white)
        .scrollContentBackground(.hidden)
        .environmentObject(trackStore)
        .onAppear {
            viewModel.setTrackStore(trackStore)
        }
        .sheet(item: $viewModel.nowPlayingViewModel) { viewModel in
            NowPlayingView(viewModel: viewModel)
        }
        .errorAlert(error: $viewModel.error)
    }
    
    private var listView: some View {
        List {
            Section {
                ForEach(trackStore.tracks) { track in
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
            } header: {
                Color.clear
            }
        }
    }
    
    private var shouldShowEmptyState: Bool {
        trackStore.tracks.isEmpty && !trackStore.fetching
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
            let viewModel = AddTrackViewModel(service: SpotifyService())
            return AddTrackView(path: $path, viewModel: viewModel).eraseToAnyView()
        case .editTrack(track: let track):
            let viewModel = TrackDetailsViewModel(track: track, service: SpotifyService(), isEditing: true)
            return TrackDetailsView(viewModel: viewModel, path: $path).eraseToAnyView()
        }
    }
}

struct TrackListView_Previews: PreviewProvider {
    
    static var previews: some View {
        TrackListView()
    }
}
