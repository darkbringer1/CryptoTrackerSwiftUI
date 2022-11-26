//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 10.11.2022.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinResponseModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack {
            leftColumn
            Spacer()
            if showHoldingsColumn {
                // holding price and holding coin total
                holdingsColumn
            }
            // current price and 24h change percentage
            rightColumn
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingsColumn: true)
    }
}

extension CoinRowView {
    private var leftColumn: some View {
       HStack(spacing: 2) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color(.purpleMountainMajesty))
                .frame(minWidth: 30)
                .foregroundColor(Color(.pencilLead))
           CustomImageView(viewModel: CustomImageViewModel(url: coin.image))
                .frame(width: 30, height: 30)
            Text(coin.symbol?.uppercased() ?? "No coin symbol")
               .font(.headline)
               .padding(.leading, 6)
               .foregroundColor(Color(.rosyHighlight))
        }
    }
    
    private var holdingsColumn: some View {
        VStack(alignment: .trailing) {
            Text("\(coin.currentHoldingsValue.asCurrencyWith2Decimals())")
                .bold()
            Text("\(coin.currentHoldings?.asNumberString() ?? "")")
            
            
        }
    }
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice?.asCurrencyWith6Decimals() ?? "")
                .bold()
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) > 0 ? .green : .red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
    }
}
