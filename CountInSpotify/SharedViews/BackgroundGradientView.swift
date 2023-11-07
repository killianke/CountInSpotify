//
//  BackgroundGradientView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 07/11/2023.
//

import SwiftUI

struct BackgroundGradientView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Style.Colors.accentColor.opacity(0.5), .gray.opacity(0.6)]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}

struct BackgroundGradientView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradientView()
    }
}
