//
//  StoreView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 22/11/2023.
//

import SwiftUI
import StoreKit
import SpotifyiOS

struct StoreView: View, UIViewControllerRepresentable {

    typealias UIViewControllerType = SKStoreProductViewController

    @Binding var showStoreView: Bool
    
    let appId: String
    
    func makeUIViewController(context: Context) -> SKStoreProductViewController {
        let viewController = SKStoreProductViewController()
        viewController.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: appId])
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: SKStoreProductViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, SKStoreProductViewControllerDelegate {
        let parent: StoreView

        init(parent: StoreView) {
            self.parent = parent
        }
        
        func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
            parent.showStoreView = false
        }
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView(showStoreView: .constant(true), appId: "\(SPTAppRemote.spotifyItunesItemIdentifier())")
    }
}
