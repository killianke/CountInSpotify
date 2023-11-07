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
    
    struct ButtonModifier: ViewModifier {
        var userInteractionDisabled: Bool = false
        
        func body(content: Content) -> some View {
            content
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(userInteractionDisabled ? .gray : Style.accentColor.opacity(0.7))
                .disabled(userInteractionDisabled)
                .cornerRadius(12)
        }
    }
}
