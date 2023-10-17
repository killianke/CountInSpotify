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
        VStack(alignment: .leading) {
            AsyncImage(url: viewModel.imageURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            
            Text(viewModel.nameString).font(.title2).fontWeight(.semibold)
            Text(viewModel.artistsString).font(.body)
            Text(viewModel.albumString).font(.body)
        }
        .foregroundColor(.white)
    }
}

struct TrackInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TrackInfoView(viewModel: TrackInfoViewModel(track: .previewContent))
    }
}
