//
//  CoinMarketServiceProvider.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 13.11.2022.
//

import Foundation
import CombineNetworkOperationPackage

class CoinMarketServiceProvider: APIServiceProvider<CoinMarketRequestModel> {
    init(request: CoinMarketRequestModel) {
        super.init(method: .get,
                   baseURL: "https://api.coingecko.com/api/v3/",
                   path: "coins/markets",
                   data: request)
    }
}
