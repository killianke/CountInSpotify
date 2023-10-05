//
//  TrackRow.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 05/10/2023.
//

import SwiftUI

struct TrackRowView: View {
    
    let viewModel: TrackRowViewModel
    var track: SpotifyTrack
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(track.name ?? "Unknown").font(.headline)
            Text(viewModel.getArtistsString(for: track)).font(.caption)
            Text(track.album?.name ?? "Unknown").font(.caption2)
        }
    }
}

struct TrackRowView_Previews: PreviewProvider {
    static var previews: some View {
        TrackRowView(viewModel: TrackRowViewModel(), track: SpotifyTrack.previewContent)
    }
}
