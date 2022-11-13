//
//  APIManager.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 13.11.2022.
//

import Foundation
import Combine

public class APIManager {
    
    public static let shared = APIManager()
    private let defaultQueue = DispatchQueue.global(qos: .default)
    private let mainQueue = DispatchQueue.main
    
    private var jsonDecoder = JSONDecoder()
    
    let urlSession: URLSession!
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    /// Dispatches a URLRequest and returns a publisher
    /// - Parameter request: URLRequest
    /// - Returns: A publisher with the provided decoded data or an error
    public func dispatch<ReturnType>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkRequestError> where ReturnType: Codable {
        
        //Log request
        debugPrint("[\(request.httpMethod?.uppercased() ?? "")] '\(String(describing: request.url))'")
        return urlSession
            .dataTaskPublisher(for: request)
            .subscribe(on: defaultQueue)
            // Map on Request response
            .tryMap ({ data, response in
                // If the response is invalid, throw an error
                guard let response = response as? HTTPURLResponse else {
                    throw self.httpError(0)
                }
                
                // Log request response
                debugPrint("[\(response.statusCode)] '\(String(describing: response.url))'")
                
                if !(200...299).contains(response.statusCode) {
                    throw self.httpError(response.statusCode)
                }
                
                // Return response data
                return data
            })
            .receive(on: mainQueue)
            // Decoded data using the ReturnType
            .decode(type: ReturnType.self, decoder: jsonDecoder)
            // Handle any decoding errors
            .mapError { error in
                return self.handleError(error)
            }
            // Expose the publisher
            .eraseToAnyPublisher()
    }
    
    /// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Mapped Error
    private func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
            case 400: return .badRequest
            case 401: return .unauthorized
            case 403: return .forbidden
            case 404: return .notFound
            case 402, 405...499: return .error4xx(statusCode)
            case 500: return .serverError
            case 501...599: return .error5xx(statusCode)
            default: return .unknownError
        }
    }
    
    /// Parses URLSession Publisher errors and return proper ones
    /// - Parameter error: URLSession publisher error
    /// - Returns: Readable NetworkRequestError
    private func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
            case is Swift.DecodingError:
                return .decodingError(error.localizedDescription)
            case let urlError as URLError:
                return .urlSessionFailed(urlError)
            case let error as NetworkRequestError:
                return error
            default:
                return .unknownError
        }
    }
}
