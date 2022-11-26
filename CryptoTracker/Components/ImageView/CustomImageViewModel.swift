//
//  CustomImageViewModel.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 26.11.2022.
//

import UIKit
import Combine

class CustomImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var dataService: CustomImageService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(url: String?) {
        self.dataService = CustomImageService(url: url)
        self.isLoading = true
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$imageData.sink { [weak self] _ in
            self?.isLoading = false
        } receiveValue: { [weak self] data in
            guard let data = data else { return }
            self?.image = UIImage(data: data)
        }
        .store(in: &cancellables)
    }
}
