//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 11.12.2022.
//

import SwiftUI

struct PortfolioView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Hello world!")
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    XMarkButton()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
