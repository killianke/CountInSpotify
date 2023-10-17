//
//  PlaybackView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 17/10/2023.
//

import SwiftUI

struct PlaybackView: View {
    @StateObject var viewModel: PlaybackViewModel

    var body: some View {
        ZStack {
            Style.backgroundGradient
            VStack(spacing: 16) {
                TrackInfoView(viewModel: viewModel.trackInfoViewModel)
            }
        }
    }
}

struct PlaybackView_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackView(viewModel: PlaybackViewModel(track: .previewContent))
    }
}
