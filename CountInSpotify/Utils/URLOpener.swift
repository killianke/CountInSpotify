//
//  URLOpener.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 03/01/2024.
//

import Foundation

protocol URLOpening {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?)
}

extension UIApplication: URLOpening {
    //Empty implementation
}

struct URLOpener {
    
    private let handler: URLOpening
    
    init(handler: URLOpening = UIApplication.shared) {
        self.handler = handler
    }
        
    func open(url: URL, completionHandler: ((Bool) -> Void)? = nil) {
        if handler.canOpenURL(url) {
            handler.open(url, options: [:], completionHandler: completionHandler)
        }
    }
}

