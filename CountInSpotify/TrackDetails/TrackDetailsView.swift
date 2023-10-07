//
//  TrackDetailsView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 06/10/2023.
//

import SwiftUI

struct TrackDetailsView: View {
    
    @EnvironmentObject var store: TrackStore
    @StateObject var viewModel: TrackDetailsViewModel
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: viewModel.imageURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 250, height: 250)
            .padding(.top, 50)
            .padding(.bottom, 25)
                        
            Text(viewModel.nameString).font(.title)
            Text(viewModel.artistsString).font(.title2)
            Text(viewModel.albumString).font(.title3)
            Text("BPM: \(viewModel.bpmString)")
            
            Spacer()
            
            Button {
                store.addTrack(viewModel.track)
                withAnimation(.easeInOut) {
                    path.removeLast()
                }
            } label: {
                Text("Add to my songs")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(viewModel.buttonDisabled ? .gray : .red)
            .disabled(viewModel.buttonDisabled)
            .cornerRadius(12)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(20)
        .errorAlert(error: $viewModel.error)
    }
}

struct TrackDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TrackDetailsView(viewModel: TrackDetailsViewModel(track: .previewContent),
                         path: .constant(NavigationPath()))
    }
}
