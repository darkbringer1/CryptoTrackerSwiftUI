//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 9.11.2022.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
                    .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
            }
        }
    }
}
