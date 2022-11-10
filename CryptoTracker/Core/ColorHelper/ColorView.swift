//
//  ColorView.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 9.11.2022.
//

import SwiftUI

struct ColorView: View {
    var body: some View {
        ZStack {
            // background layer
            Color.gray
                .ignoresSafeArea()
            
            // content layer
            VStack {
                Text("App Colors")
                makeColorCircle(from: Color.C.allCases)
            }
        }
    }
    @ViewBuilder
    func makeColorCircle(from colors: [Color.C]) -> some View {
        ForEach(colors, id: \.color) { item in
            HStack {
                Text(item.rawValue)
                Spacer()
                Circle()
                    .foregroundColor(item.color)
                    .frame(width: 50, height: 50)
                Circle()
                    .foregroundColor(item.color)
                    .frame(width: 50, height: 50)
                    .colorScheme(.dark)
                
            }
            .padding(.horizontal, 30)
        }
    }
}

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorView()
    }
}
