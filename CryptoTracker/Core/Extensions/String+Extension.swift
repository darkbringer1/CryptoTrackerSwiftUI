//
//  String+Extension.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 9.11.2022.
//

import Foundation

extension String {
    var capitalizingFirstLetter: String {
        prefix(1).capitalized + dropFirst()
    }
}
