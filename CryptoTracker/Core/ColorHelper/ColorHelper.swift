//
//  ColorHelper.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 9.11.2022.
//

import SwiftUI

public extension Color {
    
    enum C: String, CaseIterable {
        case creamyPeach
        case rosyHighlight
        case softBlue
        case brewedMustard
        case oldGeranium
        case purpleMountainMajesty
        case roguePink
        case squeaky
        case appleValley
        case pencilLead
        case backgroundColor
        case shadowColor
        case lynxWhite
        
        var color: Color? {
            guard let color = UIColor(named: rawValue.capitalizingFirstLetter, in: .main, compatibleWith: nil) else { return nil }
            return Color(uiColor: color)
        }
    }
    
    init!(_ color: C) {
        guard let color = UIColor(named: color.rawValue.capitalizingFirstLetter, in: .main, compatibleWith: nil) else { return nil }
        self.init(uiColor: color)
    }
}
