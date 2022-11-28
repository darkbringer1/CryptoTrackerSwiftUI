//
//  UIApplication+Extension.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 27.11.2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
