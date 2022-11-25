//
//  ImageServiceProvider.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 13.11.2022.
//

import Foundation
import CombineNetworkOperationPackage

class ImageServiceProvider: APIServiceProvider<EmptyRequestModel> {
    init(url: String) {
        super.init(method: .get,
                   baseURL: url,
                   path: nil,
                   data: nil)
    }
}
