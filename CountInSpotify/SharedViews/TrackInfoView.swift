//
//  TrackInfoView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 17/10/2023.
//

import SwiftUI

struct TrackInfoView: View {
    let viewModel: TrackInfoViewModel

    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: viewModel.imageURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading) {
                Text(viewModel.nameString).font(.title2).fontWeight(.semibold)
                Text(viewModel.artistsString).font(.body)
                Text(viewModel.albumString).font(.body)
                Button {
                    print("Spotify selected")
                } label: {
                    Image("Spotify_Logo_RGB_White")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 20)
                }
            }
            .padding([.leading, .trailing], 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.white)
    }
}

struct TrackInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.teal
            TrackInfoView(viewModel: TrackInfoViewModel(track: .previewContent))
        }
    }
}
