//
//  URLParameterEncoder.swift
//  CafeComic
//
//  Created by Yashar on 6/17/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            urlComponents.setQueryItems(with: parameters)
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
    }
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: Parameters) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key,
                                                        value: "\($0.value)" ) }
    }
    
}
