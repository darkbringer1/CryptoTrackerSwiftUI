//
//  NetworkRequestError.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 13.11.2022.
//

import Foundation

public enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError( _ description: String)
    case urlSessionFailed(_ error: URLError)
    case timeOut
    case missingURL
    case unknownError
}
