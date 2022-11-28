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
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
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
    }
    
    func getCoins() {
        dataService.getCoins()
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
}
