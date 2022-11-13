//
//  RequestModel.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 13.11.2022.
//

import Foundation

struct CoinMarketRequestModel: Codable {
    var currency: String
    var ids: [String]?
    var category: String?
    var order: String?
    var limit: Int?
    var page: Int?
    var sparkline: Bool?
    
    enum CodingKeys: String, CodingKey {
        case currency = "vs_currency"
        case limit = "per_page"
        case ids, category, order, page, sparkline
    }
}
