//
//  Style.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 16/10/2023.
//

import Foundation
import SwiftUI

struct Style {
    
    struct Colors {
        static let accentColor: Color = .teal
    }
    
    struct Modifiers {
        struct DefaultButton: ViewModifier {
            var userInteractionDisabled: Bool = false
            
            func body(content: Content) -> some View {
                content
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(userInteractionDisabled ? .gray : Style.Colors.accentColor.opacity(0.7))
                    .disabled(userInteractionDisabled)
                    .cornerRadius(12)
            }
        }
    }
}
