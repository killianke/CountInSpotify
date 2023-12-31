//
//  LoadingIndicatorView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 26/10/2023.
//

import SwiftUI

struct LoadingIndicatorView: View {
    var body: some View {
        ZStack {
            Style.Colors.accentColor
                .opacity(0.75)
                .cornerRadius(12)
                .frame(width: 80, height: 80, alignment: .center)
            ProgressView()
                .tint(.white)
        }
    }
}

struct LoadingIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicatorView()
    }
}
