//
//  Router.swift
//  Movie
//
//  Created by Yashar on 6/17/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation


public typealias NetworkRouterCompletion = (_ data: Data?,_ error: BackendError?)->()
protocol NetworkRouter {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    
}

public class Router<EndPoint: EndPointType>: NetworkRouter {
    
    private var task: URLSessionTask?
    private let session = URLSession(configuration: .default)
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                
                if error != nil {
                     completion(nil, BackendError(data: nil, error: error))
                }
                
                if let response = response as? HTTPURLResponse {
                    switch response.result {
                    case .success:
                        completion(data, nil)
                    case .failure( _):
                        completion(nil, BackendError(data: data, error: error))
                    }
                }
            })
        }catch {
            completion(nil, BackendError(data: nil, error: error))
        }
        self.task?.resume()
    }
    
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        if let header = route.headers {
            request.allHTTPHeaderFields = header
        }
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(let bodyParameters,
                                    let parameterEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             parameterEncoding: parameterEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let parameterEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             parameterEncoding: parameterEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         parameterEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try parameterEncoding.encode(urlRequest: &request,
                                         bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}
extension URLRequest {
    private static var _multiPartParams = [String: Parameters]()
    private static var _media = [String: Data?]()
    
    var multiPartParams: Parameters? {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return URLRequest._multiPartParams[tmpAddress] ?? nil
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            URLRequest._multiPartParams[tmpAddress] = newValue
        }
    }
    var media: Data? {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return URLRequest._media[tmpAddress] ?? nil
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            URLRequest._media[tmpAddress] = newValue
        }
    }
}
//extension Error {
//    var statusCode: Int {
//        get {
//            return self.statusCode
//        }
//        set (value){
//            self.statusCode = value
//        }
//    }
//}


