//
//  SearchTrackView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 03/10/2023.
//

import SwiftUI

struct AddTrackView: View {
    
    @StateObject var viewModel = AddTrackViewModel()
    
    var body: some View {
        Group {
            if viewModel.tracks.isEmpty {
                Text("No results").font(.title)
            } else {
                List(viewModel.tracks) { track in
                    Text(track.name ?? "")
                }
            }
        }.searchable(text: $viewModel.searchTerm)
    }
}

struct AddTrackView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrackView()
    }
}
