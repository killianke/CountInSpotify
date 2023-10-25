//
//  View+Alerts.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 06/10/2023.
//

import Foundation
import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

extension View {
    func errorAlert(error: Binding<Error?>, buttonTitle: String = "OK") -> some View {
        let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
        return alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "")
        }
    }
}

private struct LocalizedAlertError: LocalizedError {
    let underlyingError: NSError
    
    var errorDescription: String? {
        underlyingError.localizedDescription
    }
    var recoverySuggestion: String? {
        underlyingError.localizedRecoverySuggestion
    }

    init?(error: Error?) {
        guard let localizedError = error as? NSError else { return nil }
        underlyingError = localizedError
    }
}
