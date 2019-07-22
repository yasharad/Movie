//
//  BackendError.swift
//  Movie
//
//  Created by Yashar on 7/21/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
public struct BackendError {
    
    var serverError: ServerError?
    init(data: Data?,error: Error?) {
        
        if let data = data {
            let serverError = try? JSONDecoder().decode(ServerError.self, from: data)
            self.serverError = serverError
            if let errors = self.serverError?.errors {
                self.serverError?.message = errors.joined(separator: "\n")
            }
        }else {
            self.serverError = ServerError(statusCode: nil, success: nil, errors: nil, message: error?.localizedDescription)
        }
        
    }

}


struct ServerError: Codable {
    fileprivate let statusCode: Int?
    fileprivate let success: Bool?
    fileprivate let errors: [String]?
    var message: String?
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message = "status_message"
        case success = "success"
        case errors = "errors"
    }
}
