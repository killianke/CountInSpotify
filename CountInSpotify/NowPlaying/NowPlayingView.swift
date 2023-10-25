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
                TrackInfoView(viewModel: viewModel.trackInfoViewModel)
            }.padding(16)
        }
    }
}

struct PlaybackView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView(viewModel: NowPlayingViewModel(track: .previewContent))
    }
}
