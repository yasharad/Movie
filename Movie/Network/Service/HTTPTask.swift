//
//  HTTPTask.swift
//  CafeComic
//
//  Created by Yashar on 6/17/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        parameterEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        parameterEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
   
}
