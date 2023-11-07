//
//  PlaybackView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 17/10/2023.
//

import SwiftUI

struct NowPlayingView: View {
    @StateObject var viewModel: NowPlayingViewModel

    var body: some View {
        ZStack {
            Style.backgroundGradient
            
            VStack(spacing: 16) {
                Spacer()
                
                TrackInfoView(viewModel: viewModel.trackInfoViewModel)
                
                Spacer()
                
                Button {
                    viewModel.playToggled()
                } label: {
                    if viewModel.playButtonDisabled {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Label(viewModel.playButtonData.title, systemImage: viewModel.playButtonData.image)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                .modifier(Style.ButtonModifier(userInteractionDisabled: viewModel.playButtonDisabled))
                
                Button {
                    viewModel.restartTapped()
                } label: {
                    Label("Restart", systemImage: "restart")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .modifier(Style.ButtonModifier())
            }
            .padding(16)
        }
    }
}

struct PlaybackView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = NowPlayingViewModel(track: Track.previewContent, remote: SpotifyConnectionManager.shared.remote)
        NowPlayingView(viewModel: viewModel)
    }
}
