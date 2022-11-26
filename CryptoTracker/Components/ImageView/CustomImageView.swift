//
//  ImageView.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 13.11.2022.
//

import SwiftUI
import Combine
import CombineNetworkOperationPackage

struct CustomImageView: View {
    
    @StateObject var viewModel: CustomImageViewModel
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color(.purpleMountainMajesty))
            }
        }
    }
}

struct CustomImageView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageView(viewModel: CustomImageViewModel(url: dev.coin.image))
    }
}
