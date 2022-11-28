//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 26.11.2022.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                
            TextField("Search by name or symbol", text: $searchText)
                .autocorrectionDisabled()
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding(.vertical)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .foregroundColor(
            searchText.isEmpty ? Color(.gray) : Color(.pencilLead))
        .font(.headline)
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 25)
            .fill(Color(.backgroundColor))
            .shadow(color: Color(.shadowColor), radius: 10)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
