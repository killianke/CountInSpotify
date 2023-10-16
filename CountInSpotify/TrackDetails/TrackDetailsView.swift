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
        VStack(spacing: 16) {
            
            trackInfoView
            
            Spacer()

            trackSettingsView
            
            Spacer()
            
            Button {
                viewModel.didTapAddTrack()
                path.removeLast()
            } label: {
                buttonLabel(title: "Add to my songs")
            }.modifier(ButtonStyling(userInteractionDisabled: viewModel.userInteractionDisabled))
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(16)
        .errorAlert(error: $viewModel.error)
        .onAppear {
            viewModel.setTrackStore(store)
        }
    }
    
    var trackInfoView: some View {
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
    }
    
    var trackSettingsView: some View {
        HStack(alignment: .center) {
            VStack(alignment: .center) {
                Button {
                    print("Play sample")
                } label: {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                }
                .frame(width: 44, height: 44)
                
                Text("Sample")
                    .font(.caption2)
            }
            .padding(.trailing, 16)
            
            VStack {
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
            }
        }
        .foregroundColor(.white)
        .padding(16)
        .background(Color.teal)
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

private struct ButtonStyling: ViewModifier {
    var userInteractionDisabled: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(userInteractionDisabled ? .gray : .red)
            .disabled(userInteractionDisabled)
            .cornerRadius(12)
    }
}

struct TrackDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TrackDetailsViewModel(track: .previewContent)
        TrackDetailsView(viewModel: viewModel,
                         path: .constant(NavigationPath())).environmentObject(TrackStore())
    }
}
