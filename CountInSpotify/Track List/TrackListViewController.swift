//
//  TrackListViewController.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/10/2023.
//

import UIKit
import SwiftUI

class TrackListViewController: UIViewController {
    
    let contentView = UIHostingController(rootView: TrackListView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(contentView)
        contentView.view.frame = view.bounds
        
        view.addSubview(contentView.view)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        contentView.view.frame = view.bounds
    }
}
