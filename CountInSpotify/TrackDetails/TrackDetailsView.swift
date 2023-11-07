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
        ZStack {
            Style.backgroundGradient
            VStack(spacing: 16) {
                TrackInfoView(viewModel: viewModel.trackInfoViewModel)
                
                Spacer()
                
                trackSettingsView
                
                Spacer()
                
                Button {
                    viewModel.didTapActionButton()
                    path.removeLast()
                } label: {
                    buttonLabel(title: viewModel.actionButtonTitle)
                }.modifier(Style.ButtonModifier(userInteractionDisabled: viewModel.userInteractionDisabled))
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(16)

        }
        .errorAlert(error: $viewModel.error)
        .onAppear {
            viewModel.setTrackStore(store)
        }
    }
    
    var trackSettingsView: some View {
        VStack {
            Text("Configuration").font(.headline)
            HStack(alignment: .center) {
                VStack(alignment: .center) {
                    ZStack {
                        CircularProgressView(progress: viewModel.sampleProgress)
                            .frame(width: 50, height: 50)
                        
                        Button {
                            viewModel.playSample()
                        } label: {
                            Image(systemName: "play.circle.fill")
                                .resizable()
                        }
                        .frame(width: 44, height: 44)
                    }
                    
                    Text("Sample")
                        .font(.caption2)
                }
                .padding(.trailing, 8)
                
                VStack {
                    Stepper {
                        Text("Count In Bars: \(viewModel.countInBarsString)")
                    } onIncrement: {
                        viewModel.incrementBars()
                    } onDecrement: {
                        viewModel.decrementBars()
                    }
                    .disabled(viewModel.userInteractionDisabled)
                    
                    Stepper {
                        Text("BPM: \(viewModel.bpmString)")
                    } onIncrement: {
                        viewModel.incrementBPM()
                    } onDecrement: {
                        viewModel.decrementBPM()
                    }
                    .disabled(viewModel.userInteractionDisabled)
                    
                    Stepper {
                        Text("Start: \(viewModel.startTimeString)")
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
        }
        .foregroundColor(.white)
        .padding(16)
        .background(Material.ultraThin)
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private func buttonLabel(title: String) -> some View {
        if viewModel.userInteractionDisabled {
            ProgressView()
        } else {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
    }
}

struct TrackDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TrackDetailsViewModel(track: .previewContent,
                                              service: MockSpotifyService())
        TrackDetailsView(viewModel: viewModel,
                         path: .constant(NavigationPath())).environmentObject(TrackStore())
    }
}
