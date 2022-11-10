//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 10.11.2022.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    
    var body: some View {
        HStack {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color(.purpleMountainMajesty))
                .frame(width: 30, height: 30)
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol?.uppercased() ?? "ETH")
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin)
    }
}
