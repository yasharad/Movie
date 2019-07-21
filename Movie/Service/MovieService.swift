//
//  MovieService.swift
//  Movie
//
//  Created by Yashar on 7/21/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation

protocol MovieServiceProtocol {
    func getMoviesByQuery(query: String,page: Int, completion: @escaping (_ comicItem: String? ,_ error: String?)->())
}
final class MovieService {
    private let provider = Router<MovieEndPoint>()
}
// ===========================
// MARK: - MovieServiceProtocol
// ===========================
extension MovieService: MovieServiceProtocol {
    func getMoviesByQuery(query: String, page: Int, completion: @escaping (String?, String?) -> ()) {

        provider.request(.getMoiviesByQuery(query: query, page: page)) { (data, error) in
            
        }
    }
    
    
}
