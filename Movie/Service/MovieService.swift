//
//  MovieService.swift
//  Movie
//
//  Created by Yashar on 7/21/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation

protocol MovieServiceProtocol {
    func getMoviesByQuery(query: String,page: Int, completion: @escaping (_ movie: MovieModel? ,_ error: String?)->())
}
final class MovieService {
    private let provider = Router<MovieEndPoint>()
}
// ===========================
// MARK: - MovieServiceProtocol
// ===========================
extension MovieService: MovieServiceProtocol {
    func getMoviesByQuery(query: String, page: Int, completion: @escaping (MovieModel?, String?) -> ()) {

        provider.request(.getMoiviesByQuery(query: query, page: page)) { (data, error) in
            if error != nil {
                completion(nil, error?.serverError?.message)
            }
            guard let responseData = data else {
                completion(nil, TechnicianErrors.noData.errorDescription)
                return
            }
            do {
                
                let response =
                    try JSONDecoder().decode(MovieModel.self, from: responseData)

                completion(response, nil)
                
            }catch {
                print(error)
                completion(nil, TechnicianErrors.unableToDecode.errorDescription)
            }
            
        }
    }
    
}
