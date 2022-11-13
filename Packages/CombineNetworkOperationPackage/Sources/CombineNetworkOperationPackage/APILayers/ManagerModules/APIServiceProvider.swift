//
//  APIServiceProvider.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 13.11.2022.
//

import Foundation

open class APIServiceProvider<T: Codable> {
    private var method: HTTPMethod
    private var baseURL: String
    private var path: String?
    private var data: T?
    
    public init(method: HTTPMethod = .get,
                baseURL: String,
                path: String? = nil,
                data: T? = nil) {
        self.method = method
        self.baseURL = baseURL
        self.path = path
        self.data = data
    }
    
    public func returnURLRequest() throws -> URLRequest {
        var url = try baseURL.asURL()
        
        if let path = path {
            if #available(iOS 16.0, *) {
                url = url.appending(path: path)
            } else {
                // Fallback on earlier versions
                url = url.appendingPathComponent(path)
            }
        }
        var request =  URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        try configureEncoding(request: &request)
        return request
    }
    
    private func configureEncoding(request: inout URLRequest) throws {
        switch method {
            case .post, .put:
                try ParameterEncoding.jsonEncoding.encode(urlRequest: &request, parameters: params)
            case .get:
                try ParameterEncoding.urlEncoding.encode(urlRequest: &request, parameters: params)
            default:
                try ParameterEncoding.urlEncoding.encode(urlRequest: &request, parameters: params)
        }
    }
    
    private var params: [String: Any] {
        return data.asDictionary()
    }
}
