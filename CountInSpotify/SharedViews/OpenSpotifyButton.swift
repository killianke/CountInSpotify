//
//  OpenSpotifyButton.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 04/01/2024.
//

import SwiftUI

struct OpenSpotifyButton: View {
    
    var buttonAction: () -> Void
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            Label {
                Text("Open Spotify")
            } icon: {
                Style.Images.spotifyIconWhite
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 20)
            }
        }
        .tint(.white)
        .padding(15)
        .background(Color.teal)
        .cornerRadius(25)
    }
}

struct OpenSpotifyButton_Previews: PreviewProvider {
    static var previews: some View {
        OpenSpotifyButton() {
            
        }.previewLayout(.sizeThatFits)
    }
}
