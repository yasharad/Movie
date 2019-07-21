//
//  MovieViewModel.swift
//  Movie
//
//  Created by Yashar on 7/21/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
struct MovieViewModel {

    
    var movieTitle: String?
    var movieOverView: String?
    var movieDate: String?
    var moviePosterUrl: URL?
    init(movie: MovieResult) {
        self.movieTitle = movie.title
        self.movieOverView = movie.overview
        self.movieDate = movie.releaseDate
        if let url = movie.posterPath {
         moviePosterUrl = URL(string: NetworkManager.environmentImageURL + ImageSize.small + url)
    }
}
}
