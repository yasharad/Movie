//
//  HandleResponse.swift
//  Movie
//
//  Created by Yashar on 6/19/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation

enum Result<T> {
    case success
    case failure(T)
}

extension HTTPURLResponse {
    var result: Result<Int> {
        switch statusCode {
        case 200...299:
            return .success
        default:
            return .failure(statusCode)
        }
    }
}
