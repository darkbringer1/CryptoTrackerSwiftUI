//
//  EndpointHelper.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 13.11.2022.
//

import Foundation

typealias BaseURL = EndpointManager.BaseURL
typealias Path = EndpointManager.Paths

enum EndpointManager {
    enum BaseURL: GenericValueProtocol {
        typealias Value = String
        
        case coingeckoV3
        var value: String {
            switch self {
                case .coingeckoV3:
                    return "https://api.coingecko.com/api/v3/"
            }
        }
    }
    
    enum Paths: GenericValueProtocol {
        typealias Value = String
        
        case coinMarket
        case global
        
        var value: String {
            switch self {
                case .coinMarket:
                    return "coins/markets"
                case .global:
                    return "global"
            }
        }
    }
}
