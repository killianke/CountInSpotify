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
                    viewModel.restartTapped()
                } label: {
                    Label("Restart", systemImage: "restart.circle.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Style.accentColor.opacity(0.7))
                .cornerRadius(12)
            }
            .padding(16)
        }
    }
}

struct PlaybackView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = NowPlayingViewModel(track: .previewContent, remote: SpotifyConnectionManager.shared.remote)
        NowPlayingView(viewModel: viewModel)
    }
}
