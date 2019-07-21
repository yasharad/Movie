//
//  EndpointType.swift
//  Movie
//
//  Created by Yashar on 6/17/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
public protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
  
    
}
