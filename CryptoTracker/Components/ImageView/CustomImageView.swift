//
//  ImageView.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 13.11.2022.
//

import SwiftUI
import Combine
import CombineNetworkOperationPackage

class CustomImageService {
    @Published var image: Data? = nil
    
    var imageSubscription: AnyCancellable?
    
    init(url: String) {
        getImage(url: url)
    }
    
    private func getImage(url: String) {
        guard let request = try? ImageServiceProvider(url: url).returnURLRequest() else { return }
        imageSubscription = APIManager.shared.dispatch(request: request)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] result in
                self?.image = result
            })
        imageSubscription?.cancel()
    }
}
class CustomImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var dataService: CustomImageService?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
    
    func getImage(url: String) {
        dataService = CustomImageService(url: url)
        guard let data = dataService?.image else { return }
        image = UIImage(data: data)
    }
}
struct CustomImageView: View {
    
    @StateObject var viewModel: CustomImageViewModel = CustomImageViewModel()
    
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
        CustomImageView()
    }
}
