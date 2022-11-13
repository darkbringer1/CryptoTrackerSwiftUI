//
//  ParameterEncoding.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 13.11.2022.
//

import Foundation

public enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding
    
    public func encode(urlRequest: inout URLRequest, parameters: [String: Any]?) throws {
        do {
            switch self {
                case .urlEncoding:
                    guard let urlParameters = parameters else { return }
                    try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                case .jsonEncoding:
                    guard let bodyParameters = parameters else { return }
                    try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        }
    }
}

