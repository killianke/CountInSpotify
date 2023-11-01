//
//  Style.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 16/10/2023.
//

import Foundation
import SwiftUI

struct Style {
    
    static let accentColor: Color = .teal
    
    static let backgroundGradient: some View = {
        LinearGradient(gradient: Gradient(colors: [Style.accentColor.opacity(0.5), .gray.opacity(0.6)]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }()
}
