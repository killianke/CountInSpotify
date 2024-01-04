//
//  ColorExtensions.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 04/01/2024.
//

import SwiftUI

extension Color {
    init(light: @escaping @autoclosure () -> UIColor, dark: @escaping @autoclosure () -> UIColor) {
        let uiColor = UIColor(dynamicProvider: { traits in
            switch traits.userInterfaceStyle {
            case .light, .unspecified:
                return light()
            case .dark:
                return dark()
            @unknown default:
                assertionFailure("Unknown userInterfaceStyle: \(traits.userInterfaceStyle)")
                return light()
            }
        })
        self.init(uiColor: uiColor)
    }
}
