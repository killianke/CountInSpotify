//
//  UserDefaults+Extensions.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 21/09/2023.
//

import Foundation

extension UserDefaults {
    
    var spotifyToken: String? {
        get {
            return object(forKey: #function) as? String
        }
        set {
            set(newValue, forKey: #function)
        }
    }
}
