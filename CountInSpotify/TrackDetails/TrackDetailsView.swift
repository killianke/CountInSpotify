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
            .aspectRatio(contentMode: .fit)
            .padding([.leading, .trailing], 20)
                        
            Text(viewModel.nameString).font(.title)
            Text(viewModel.artistsString).font(.title2)
            Text(viewModel.albumString).font(.title3)
            
            Spacer()

            Stepper {
                Text("BPM: \(viewModel.bpmString)")
            } onIncrement: {
                viewModel.incrementBPM()
            } onDecrement: {
                viewModel.decrementBPM()
            }
            .disabled(viewModel.userInteractionDisabled)
            
            Stepper {
                Text("Start time: \(viewModel.startTimeString)")
            } onIncrement: {
                viewModel.incrementStartTime()
            } onDecrement: {
                viewModel.decrementStartTime()
            }
            .disabled(viewModel.userInteractionDisabled)
            
            Slider(value: $viewModel.trackStartTime,
                   in: viewModel.sliderRange,
                   step: viewModel.sliderStep)
            .disabled(viewModel.userInteractionDisabled)
            
            Spacer()
            
            bottomButtons
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(20)
        .errorAlert(error: $viewModel.error)
        .onAppear {
            viewModel.setTrackStore(store)
        }
    }
    
    var bottomButtons: some View {
        Group {
            Button {
                print("Play sample")
            } label: {
                buttonLabel(title: "Play Sample")
            }
            
            Button {
                viewModel.didTapAddTrack()
                path.removeLast()
            } label: {
                buttonLabel(title: "Add to my songs")
            }
        }
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(viewModel.userInteractionDisabled ? .gray : .red)
        .disabled(viewModel.userInteractionDisabled)
        .cornerRadius(12)
    }
    
    private func buttonLabel(title: String) -> AnyView {
        if viewModel.userInteractionDisabled {
            return ProgressView()
                .eraseToAnyView()
        } else {
            return Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .eraseToAnyView()
        }
    }
}

struct TrackDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TrackDetailsViewModel(track: .previewContent)
        TrackDetailsView(viewModel: viewModel,
                         path: .constant(NavigationPath())).environmentObject(TrackStore())
    }
}
