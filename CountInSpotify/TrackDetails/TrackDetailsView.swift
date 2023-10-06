//
//  TrackDetailsView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 06/10/2023.
//

import SwiftUI

struct TrackDetailsView: View {
    
    @Binding var path: NavigationPath
    @StateObject var viewModel: TrackDetailsViewModel

    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: viewModel.imageURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 250, height: 250)
            
            Text(viewModel.nameString).font(.title)
            Text(viewModel.artistsString).font(.title2)
            Text(viewModel.albumString).font(.title3)
            Text("BPM: \(viewModel.bpmString)")
        }
        .errorAlert(error: $viewModel.error)
        .padding(20)
    }
}

struct TrackDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TrackDetailsView(path: .constant(NavigationPath()), viewModel: TrackDetailsViewModel(track: .previewContent))
    }
}
