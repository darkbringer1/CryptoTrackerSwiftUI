//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 9.11.2022.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    let tintColor: Color
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(tintColor)
            .frame(width: 50, height: 50)
            .background(
            Circle()
                .foregroundColor(Color(.backgroundColor))
            )
            .shadow(
                color: tintColor,
                radius: 10
            )
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonView(iconName: "house", tintColor: Color(.purpleMountainMajesty))
            .previewLayout(.sizeThatFits)
    }
}
