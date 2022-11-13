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
    @Published var allCoins: [CoinResponseModel] = []
    var coinSubscription: AnyCancellable?
    
    init() {}
    
    func getCoins() {
        do {
            guard let request = try? CoinMarketServiceProvider(request: CoinMarketRequestModel(currency: "usd")).returnURLRequest() else { return }
            coinSubscription = APIManager.shared.dispatch(request: request)
                .sink(receiveCompletion: { _ in },
                      receiveValue: { [weak self] result in
                    self?.allCoins = result
                })
        }
        coinSubscription?.cancel()
    }
}
