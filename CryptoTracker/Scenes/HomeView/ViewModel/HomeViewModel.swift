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
    @Published var customImageViewModel: CustomImageViewModel = CustomImageViewModel()
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$allCoins.sink { [weak self] returnedCoins in
            self?.allCoins = returnedCoins
        }
        .store(in: &cancellables)
    }
    
    func getCoins() {
        dataService.getCoins()
    }
    
}
