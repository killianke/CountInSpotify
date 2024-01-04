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
        static let accentColor: Color = .init(
            light: .systemTeal,
            dark: UIColor(red: 0.12, green: 0.44, blue: 0.53, alpha: 1.00)
        )
    }
    
    struct Images {
        static let spotifyLogoWhite = Image("Spotify_Logo_RGB_White")
        static let spotifyLogoBlack = Image("Spotify_Logo_RGB_Black")
        static let spotifyIconWhite = Image("Spotify_Icon_RGB_White")
    }
    
    struct Modifiers {
        struct FullWidthButton: ViewModifier {
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
