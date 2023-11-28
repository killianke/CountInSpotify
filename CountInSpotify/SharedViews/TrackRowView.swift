//
//  TrackRow.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 05/10/2023.
//

import SwiftUI

struct TrackRowView: View {
    
    let viewModel: TrackRowViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: viewModel.imageURL) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 64, height: 64)
            
            VStack(alignment: .leading) {
                Text(viewModel.nameString).font(.headline)
                Text(viewModel.artistsString).font(.caption)
                Text(viewModel.albumString).font(.caption2)
                Image("Spotify_Logo_RGB_Black")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 12)
            }
        }
    }
}

struct TrackRowView_Previews: PreviewProvider {
    static var previews: some View {
            TrackRowView(viewModel: TrackRowViewModel(track: .previewContent))
            .previewLayout(.sizeThatFits)
    }
}
