//
//  NetworkManager.swift
//  Movie
//
//  Created by Yashar on 6/17/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
struct NetworkManager {
    static  let shared = NetworkManager()
    private static let environment: NetworkEnvironment = .production
    static var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .qa:         return "https://gateway.marvel.com/v1/public"
        case .staging:    return "https://gateway.marvel.com/v1/public"
        case .production: return "https://gateway.marvel.com/v1/public"
        }
    }
    
}
