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
    @Published var imageData: UIImage? = nil
    
    private let fileManager = LocalFileManager.instance
    private var imageSubscription: AnyCancellable?
    private let folderName = "coin_images"
    
    init(url: String?) {
        getImage(with: url)
    }
    
    private func getImage(with url: String?) {
        guard let url = url else { return }
        if let image = fileManager.imageLoadingProcess(data: nil, url: url) {
            imageData = image
        } else {
            downLoadImage(url: url)
        }
    }
    
    private func downLoadImage(url: String?) {
        guard let url = url,
              let request = try? ImageServiceProvider(url: url).returnURLRequest() else { return }
        APIManager.shared.download(request: request)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] result in
                self?.imageData = self?.fileManager.imageLoadingProcess(data: result, url: url)
            }).cancel()
    }
}
