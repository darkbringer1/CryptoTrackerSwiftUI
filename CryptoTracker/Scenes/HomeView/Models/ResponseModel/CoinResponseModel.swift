//
//  CoinModel.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 10.11.2022.
//

import Foundation
/*
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h
 */

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct CoinResponseModel: Codable, Identifiable {
    var id, symbol, name: String?
    var image: String?
    var currentPrice: Double?
    var marketCap, marketCapRank: Double?
    var fullyDilutedValuation: Double?
    var totalVolume, high24H, low24H, priceChange24H: Double?
    var priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H, circulatingSupply: Double?
    var totalSupply, maxSupply: Double?
    var ath, athChangePercentage: Double?
    var athDate: String?
    var atl, atlChangePercentage: Double?
    var atlDate: String?
    var roi: Roi?
    var lastUpdated: String?
    var sparklineIn7D: SparklineIn7D?
    var priceChangePercentage24HInCurrency: Double?
    var currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
    }
    
    func updateHoldings(amount: Double) -> CoinResponseModel {
        
        return CoinResponseModel(id: id,
                         symbol: symbol,
                         name: name,
                         image: image,
                         currentPrice: currentPrice,
                         marketCap: marketCap,
                         marketCapRank: marketCapRank,
                         fullyDilutedValuation: fullyDilutedValuation,
                         totalVolume: totalVolume,
                         high24H: high24H,
                         low24H: low24H,
                         priceChange24H: priceChange24H,
                         priceChangePercentage24H: priceChangePercentage24H,
                         marketCapChange24H: marketCapChange24H,
                         marketCapChangePercentage24H: marketCapChangePercentage24H,
                         circulatingSupply: circulatingSupply,
                         totalSupply: totalSupply,
                         maxSupply: maxSupply,
                         ath: ath,
                         athChangePercentage: athChangePercentage,
                         athDate: athDate,
                         atl: atl,
                         atlChangePercentage: atlChangePercentage,
                         atlDate: atlDate,
                         roi: roi,
                         lastUpdated: lastUpdated,
                         sparklineIn7D: sparklineIn7D,
                         priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency)
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * (currentPrice ?? 0)
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

// MARK: - Roi
struct Roi: Codable {
    var times: Double?
    var currency: Currency?
    var percentage: Double?
}

enum Currency: String, Codable {
    case btc = "btc"
    case eth = "eth"
    case usd = "usd"
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    var price: [Double]?
}
