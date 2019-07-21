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
        case .qa:         return "http://api.themoviedb.org/3/search/movie"
        case .staging:    return "http://api.themoviedb.org/3/search/movie"
        case .production: return "http://api.themoviedb.org/3/search/movie"
        }
    }
    
}



//static let imageUrl = "http://image.tmdb.org/t/p/"
