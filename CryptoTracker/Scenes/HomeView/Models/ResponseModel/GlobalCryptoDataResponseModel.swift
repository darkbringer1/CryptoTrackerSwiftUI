//
//  GlobalCryptoDataResponseModel.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 29.11.2022.
//

import Foundation

// MARK: - GlobalCryptoData
struct GlobalCryptoData: Codable {
    var data: MarketData?
}

// MARK: - MarketData
struct MarketData: Codable {
    var activeCryptocurrencies, upcomingIcos, ongoingIcos, endedIcos: Int?
    var markets: Int?
    var totalMarketCap, totalVolume, marketCapPercentage: [String: Double]?
    var marketCapChangePercentage24HUsd: Double?
    var updatedAt: Int?
    
    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoing_icos"
        case endedIcos = "ended_icos"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case updatedAt = "updated_at"
    }
    
    mutating func getDominance(for coin: String) -> String {
        if let item = marketCapPercentage?.first(where: { $0.key == coin }) {
            return item.value.asPercentString()
        }
        return ""
    }
    
    mutating func getMarketCapPercentage(for coin: String) -> Double {
        if let item = marketCapPercentage?.first(where: { $0.key == coin }) {
            return item.value
        }
        return 0
    }
        
    mutating func getVolume(for coin: String) -> String {
        if let item = totalVolume?.first(where: { $0.key == coin }) {
            return "\(item.value)"
        }
        return ""
    }
}
