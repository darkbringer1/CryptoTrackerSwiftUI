//
//  CustomImageService.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 26.11.2022.
//

import UIKit
import Combine
import CombineNetworkOperationPackage

class CustomImageService {
    @Published var imageData: Data? = nil
    
    private var imageSubscription: AnyCancellable?
    
    init(url: String?) {
        getImage(url: url)
    }
    
    private func getImage(url: String?) {
        guard let url = url, let request = try? ImageServiceProvider(url: url).returnURLRequest() else { return }
        APIManager.shared.download(request: request)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] result in
                self?.imageData = result
            }).cancel()
    }
}
