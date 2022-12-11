//
//  CalendarView.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 11.12.2022.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        CalendarWidget()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}



extension Date {
    // Returns the month and year as a string, e.g. "January 2022"
    var monthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }
    
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    
    // Returns the date of the first day of the month
    var startOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
    
    // Returns the day of the week as an integer (1 = Sunday, 2 = Monday, etc.)
    var weekday: Int {
        let calendar = Calendar.current
        return calendar.component(.weekday, from: self)
    }
    
    // Returns the date of the last day of the month
    var endOfMonth: Date {
        // Start by getting the start of the next month
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        let startOfNextMonth = calendar.date(byAdding: components, to: startOfMonth)!
        
        // Then get the start of the next month, and subtract one day
        let endOfMonth = startOfNextMonth.addingTimeInterval(-24 * 60 * 60)
        return endOfMonth
    }
}

struct CalendarWidget: View {
    // The current date, which will be displayed in the widget
    @State private var currentDate = Date()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(.pencilLead))
            VStack {
                // Display the current month and year at the top of the widget
                Text("\(currentDate.monthYear)")
                    .font(.largeTitle)
                    .foregroundColor(Color(.squeaky))
                
                // Create a grid of the days in the current month
                // Each day is a button that can be tapped to update the current date
                // The current date is highlighted in yellow
                CalendarGrid(currentDate: $currentDate)
            }
            .padding()
        }
    }
}

//struct CalendarGrid: View {
//    @Binding var currentDate: Date
//
//    var body: some View {
//        // Create a 7x6 grid to represent the days in the current month
//        // (7 columns for the days of the week, 6 rows for the weeks in the month)
//        VStack(alignment: .leading) {
//            ForEach(0..<6, id: \.self) { row in
//                HStack(spacing: 0) {
//                    ForEach(0..<7, id: \.self) { column in
//                        // Calculate the date for the current day in the grid
//                        let date = self.date(forColumn: column, row: row)
//
//                        // Only display the day if it is within the current month
//                        if date >= self.currentDate.startOfMonth && date <= self.currentDate.endOfMonth {
//                            // Create a button for the current day, which will update the current date
//                            // when tapped. The current date is highlighted in yellow.
//                            Button(action: {
//                                self.currentDate = date
//                            }) {
//                                Text("\(date.day)")
//                                    .foregroundColor(date == self.currentDate ? .yellow : .black)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    // Calculates the date for the given column and row in the calendar grid
//    func date(forColumn column: Int, row: Int) -> Date {
//        // Start with the first day of the current month
//        var date = currentDate.startOfMonth
//
//        // Move to the first day of the week (Sunday)
//        while date.weekday != 1 {
//            date = date.addingTimeInterval(-24 * 60 * 60)
//        }
//
//        // Move to the correct column by adding the number of days to the current date
//        date = date.addingTimeInterval(TimeInterval(column * 24 * 60 * 60))
//
//        // Move to the correct row by adding the number of weeks to the current date
//        date = date.addingTimeInterval(TimeInterval(row * 7 * 24 * 60 * 60))
//
//        return date
//    }
//}

struct CalendarGrid: View {
    @Binding var currentDate: Date
    
    var body: some View {
        // Create a 7x6 grid to represent the days in the current month
        // (7 columns for the days of the week, 6 rows for the weeks in the month)
        VStack(alignment: .trailing) {
            ForEach(0..<6, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<7, id: \.self) { column in
                        // Calculate the date for the current day in the grid
                        let date = self.date(forColumn: column, row: row)
                        
                        // Only display the day if it is within the current month
                        if date >= self.currentDate.startOfMonth && date <= self.currentDate.endOfMonth {
                            // Create a button for the current day, which will update the current date
                            // when tapped. The current date is highlighted in yellow.
                            Button(action: {
                                self.currentDate = date
                            }) {
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color(.lynxWhite))
                                        .frame(maxWidth: 35)
                                    Text("\(date.day)")
                                        .foregroundColor(date == self.currentDate ? Color(.squeaky) : .black)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Calculates the date for the given column and row in the calendar grid
    func date(forColumn column: Int, row: Int) -> Date {
        // Start with the first day of the current month
        var date = currentDate.startOfMonth
        
        // Move to the first day of the week (Sunday)
        while date.weekday != 1 {
            date = date.addingTimeInterval(-24 * 60 * 60)
        }
        
        // Move to the correct column by adding the number of days to the current date
        date = date.addingTimeInterval(TimeInterval(column * 24 * 60 * 60))
        
        // Move to the correct row by adding the number of weeks to the current date
        date = date.addingTimeInterval(TimeInterval(row * 7 * 24 * 60 * 60))
        
        return date
    }
}
