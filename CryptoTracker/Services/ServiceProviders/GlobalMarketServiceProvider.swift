//
//  GlobalMarketServiceProvider.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 29.11.2022.
//

import Foundation
import CombineNetworkOperationPackage

class GlobalMarketServiceProvider: APIServiceProvider<EmptyRequestModel> {
    init() {
        super.init(method: .get,
                   baseURL: BaseURL.coingeckoV3.value,
                   path: Path.global.value,
                   data: EmptyRequestModel())
    }
}
