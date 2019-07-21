//
//  MovieEndPoint.swift
//  Movie
//
//  Created by Yashar on 7/21/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation

enum MovieEndPoint {
    case getMoiviesByQuery(query: String, page: Int)
}

// ===========================
// MARK: - EndPointType
// ===========================
extension MovieEndPoint: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: NetworkManager.environmentBaseURL) else {
            fatalError("baseURL could not be configured.")}
        return url
    }
    
    
    var path: String {
        switch self {
        case .getMoiviesByQuery(_):
            return "/query"
        
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getMoiviesByQuery(_,_):
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getMoiviesByQuery(let query,let page):
            let params: Parameters =  ["query": query,
                                        "page": page,
                                        "api_key": MovieKey.apiKey]
            return .requestParameters(bodyParameters: nil, parameterEncoding: .urlEncoding, urlParameters: params)
            
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
