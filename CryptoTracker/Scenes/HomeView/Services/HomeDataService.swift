//
//  HomeDataService.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 29.11.2022.
//

import Foundation
import Combine
import CombineNetworkOperationPackage

class HomeDataService {
    @Published var marketData: MarketData? = nil
    @Published var allCoins: [CoinResponseModel] = []
    
    private var marketDataSubscription: AnyCancellable?
    private var coinSubscription: AnyCancellable?

    init() {
        getCoins()
        getMarketData()
    }
    
    private func getMarketData() {
        do {
            guard let request = try? GlobalMarketServiceProvider().returnURLRequest() else { return }
            marketDataSubscription = APIManager.shared.download(request: request)
                .decode(type: GlobalCryptoData.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { (data) in
                    switch data {
                        case .finished:
                            debugPrint("finished marketdata")
                        case .failure(let error):
                            debugPrint("failed marketdata \(error.localizedDescription)")
                    }
                }, receiveValue: { [weak self] response in
                    self?.marketData = response.data
                })
        }
        marketDataSubscription?.cancel()
    }
    
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
