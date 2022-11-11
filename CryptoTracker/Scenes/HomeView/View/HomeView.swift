//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 9.11.2022.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio: Bool = true
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        ZStack {
            Color(.backgroundColor)
                .ignoresSafeArea()
            
            VStack {
                homeHeader
                
                columnTitles
                
                if !showPortfolio {
                    
                    allCoinsList
                    .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info",
                             tintColor: Color(.purpleMountainMajesty))
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                        .foregroundColor(Color(.appleValley))
                )
            
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color(.pencilLead))
            Spacer()
            CircleButtonView(iconName: "chevron.right",
                             tintColor: Color(.purpleMountainMajesty))
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: showPortfolio)
            }
            .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: showPortfolio)
            }
            .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .listStyle(PlainListStyle())
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
        }
        .font(.subheadline)
        .padding(.horizontal)
        .foregroundColor(Color(.pencilLead))
    }
}
