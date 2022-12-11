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
                HomeHeader()
                StatsView()
                SearchBarView(searchText: $vm.searchText)
                ColumnTitles()
                if !showPortfolio {
                    AllCoinsList()
                    .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    PortfolioCoinsList()
                        .transition(.move(edge: .trailing))
                }
                Spacer()
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            vm.getCoins()
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
    
    @ViewBuilder
    private func HomeHeader() -> some View {
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
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 360))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                    vm.getCoins()
                }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func AllCoinsList() -> some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: showPortfolio, imageUrl: coin.image ?? "")
                    .onTapGesture {
                        print("\(coin.id)")
                    }
            }
            .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .listStyle(PlainListStyle())
//        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    private func PortfolioCoinsList() -> some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: showPortfolio, imageUrl: coin.image ?? "")
            }
            .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .listStyle(PlainListStyle())
//        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    private func ColumnTitles() -> some View {
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
   
    @ViewBuilder
    private func StatsView() -> some View {
        HStack {
            ForEach(vm.stats) { stat in
                StatisticView(stat: stat)
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}
