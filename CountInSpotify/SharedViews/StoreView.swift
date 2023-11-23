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

    typealias UIViewControllerType = StoreViewController

    @Binding var showStoreView: Bool
    
    let appId: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<StoreView>) -> StoreViewController {
        return StoreViewController(coordinator: context.coordinator, appId: appId)
    }

    func updateUIViewController(_ uiViewController: StoreViewController, context: UIViewControllerRepresentableContext<StoreView>) {}
    
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

class StoreViewController: UIViewController {
    private let coordinator: StoreView.Coordinator
    private let appId: String
    
    private var storeController: SKStoreProductViewController?
    
    init(coordinator: StoreView.Coordinator, appId: String) {
        self.coordinator = coordinator
        self.appId = appId
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        storeController = SKStoreProductViewController()
        storeController?.delegate = coordinator
        
        storeController?.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: appId])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let vc = storeController {
            present(vc, animated: true)
        }
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView(showStoreView: .constant(true), appId: "\(SPTAppRemote.spotifyItunesItemIdentifier())")
    }
}
