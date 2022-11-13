//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 12.11.2022.
//

import Foundation
import Combine
import CombineNetworkOperationPackage

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        do {
            guard let request = try? CoinMarketServiceProvider(request: CoinMarketRequestModel(currency: "usd")).returnURLRequest() else { return }
            coinSubscription = APIManager.shared.dispatch(request: request)
                .sink { _ in }
        receiveValue: { coins in
            self.allCoins = coins
        }
        }
        coinSubscription?.cancel()
    }
}
