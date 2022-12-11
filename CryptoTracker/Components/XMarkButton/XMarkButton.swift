//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 11.12.2022.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button(action: {
            dismiss()
            print("Dismiss")
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(Color(.pencilLead))
        })
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
