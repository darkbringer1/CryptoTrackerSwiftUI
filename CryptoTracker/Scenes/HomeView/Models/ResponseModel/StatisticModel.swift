//
//  StatisticModel.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 29.11.2022.
//

import Foundation

struct StatisticModel: Codable, Identifiable {
    var id = UUID().uuidString
    var title: String
    var value: String
    var percentageChange: Double?
    
    init(title: String,
         value: String,
         percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
