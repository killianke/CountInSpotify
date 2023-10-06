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
        VStack(alignment: .leading) {
            Text(viewModel.nameString).font(.headline)
            Text(viewModel.artistsString).font(.caption)
            Text(viewModel.albumString).font(.caption2)
        }
    }
}

struct TrackRowView_Previews: PreviewProvider {
    static var previews: some View {
        TrackRowView(viewModel: TrackRowViewModel(track: .previewContent))
    }
}
