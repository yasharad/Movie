//
//  TechnicianErrors.swift
//  CafeComic
//
//  Created by Yashar on 6/19/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
enum TechnicianErrors: Error {
    case connectionTimeout
    case forbidden(messages: String?)
    case noNetworkConnectivity
    case notFound(messages: String?)
    case unAuthorized(messages: String?)
    case other(messages: String?)
    case rechability
    case noData
    case badRequest
    case outdated
    case failed
    case unableToDecode
    case methodNotAllowed(messages: String?)
    case missing(messages: String?)
    
    var errorDescription: String? {
        switch self {
        case .connectionTimeout:
            return "No Network Access"
        case .forbidden(let messages):
            return messages ?? "Forbidden"
        case .noNetworkConnectivity:
            return "Turn on cellular data or use Wi-Fi to access the app"
        case .notFound(let messages):
            return messages ?? "ResourceNotFound"
        case .unAuthorized(let messages):
            return messages ?? "Unauthorized"
        case .other(let messages):
            return messages ?? "Unknown Error"
        case .rechability:
            return "Please check internet"
        case .noData:
            return "Response returned with no data to decode"
        case .badRequest:
            return "Response returned with no data to decode"
        case .outdated:
            return "The url you requested is outdated."
        case .failed:
            return "Network request failed."
        case .unableToDecode:
            return "We could not decode the response."
        case .methodNotAllowed(let messages):
            return messages ?? "Method Not Allowed."
        case .missing(let messages):
            return messages ?? "Missing Key"
            
        }
    }
}

// ======================
// MARK: - Error Handling
// ======================
extension TechnicianErrors {
    
    static func handle(_ errorData: Data?, statusCode: Int) -> String {
        
        if let errorData = errorData {
            func parseErrorMessages(_ errorData: Data) -> String? {
            
               // return try? JSONDecoder().decode(BackendError.self, from: errorData).message
            }
            switch statusCode {
            case 400:
                return TechnicianErrors.other(messages: parseErrorMessages(errorData)).errorDescription!
            case 401:
                return TechnicianErrors.unAuthorized(messages: parseErrorMessages(errorData)).errorDescription!
            case 403:
                return TechnicianErrors.forbidden(messages: parseErrorMessages(errorData)).errorDescription!
            case 404:
                return TechnicianErrors.notFound(messages: parseErrorMessages(errorData)).errorDescription!
            case 405:
                return TechnicianErrors.methodNotAllowed(messages: parseErrorMessages(errorData)).errorDescription!
            case 409:
                return TechnicianErrors.missing(messages: parseErrorMessages(errorData)).errorDescription!
            case 504:
                return TechnicianErrors.connectionTimeout.errorDescription!
            case 400..<500:
                return TechnicianErrors.other(messages: parseErrorMessages(errorData)).errorDescription!
            case 501...599:
                return TechnicianErrors.badRequest.errorDescription!
            case 600:
                return TechnicianErrors.failed.errorDescription!
            default:
                return TechnicianErrors.other(messages: parseErrorMessages(errorData)).errorDescription!
            }
            
        } else {
            return TechnicianErrors.rechability.errorDescription!
        }
    }
}
