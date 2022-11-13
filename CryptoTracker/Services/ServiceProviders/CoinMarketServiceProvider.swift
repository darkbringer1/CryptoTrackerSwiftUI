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
                   baseURL: BaseURL.coingeckoV3.value,
                   path: Path.coinMarket.value,
                   data: request)
    }
}
