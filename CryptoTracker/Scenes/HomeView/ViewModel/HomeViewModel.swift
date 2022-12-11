//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 9.11.2022.
//

import Foundation
import Combine
import CombineNetworkOperationPackage

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinResponseModel] = []
    @Published var portfolioCoins: [CoinResponseModel] = []
    @Published var searchText: String = ""
    
    @Published var stats: [StatisticModel] = []
    
    private let dataService = HomeDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func getCoins() {
        dataService.getCoins()
    }
    
    private func addSubscribers() {
        dataService.$allCoins
            .combineLatest($searchText)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellables)
        
        dataService.$marketData
            .tryMap(mapStats)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] items in
                self?.stats = items
            })
            .store(in: &cancellables)
    }
    
    private func filterCoins(coins: [CoinResponseModel], text: String) -> [CoinResponseModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin -> Bool in
            guard let coinName = coin.name, let coinSymbol = coin.symbol, let coinId = coin.id else { return false }
            return coinName.lowercased().contains(lowercasedText) ||
            coinSymbol.lowercased().contains(lowercasedText) ||
            coinId.lowercased().contains(lowercasedText)
        }
    }
    
    private func mapStats(with marketData: MarketData?) -> [StatisticModel] {
        guard var marketData = marketData else { return [] }
        let stat1 = StatisticModel(title: "Market Cap", value: marketData.getMarketCap(for: "usd"), percentageChange: marketData.marketCapChangePercentage24HUsd)
        let stat2 = StatisticModel(title: "24h Volume", value: marketData.getVolume(for: "usd"))
        let stat3 = StatisticModel(title: "BTC Dominance", value: marketData.getDominance(for: "btc"))
        
        return [stat1, stat2, stat3]
    }
}
