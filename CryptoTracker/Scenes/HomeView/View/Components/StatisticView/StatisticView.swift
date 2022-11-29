//
//  StatisticView.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 29.11.2022.
//

import SwiftUI

struct StatisticView: View {
    let stat: StatisticModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color(.creamyPeach))
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color(.appleValley))
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? .green : .red)
            .opacity(stat.percentageChange == nil ? 0 : 1)
        }
        .padding(10)
        .frame(width: (UIScreen.main.bounds.width / 3) - 10, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(.backgroundColor))
                .shadow(color: Color(.shadowColor), radius: 5, x: 0, y: 0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(stat: dev.stat1)
            .preferredColorScheme(.dark)
    }
}
