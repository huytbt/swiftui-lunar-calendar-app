//
//  CalendarView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/26/20.
//

import SwiftUI

struct CalendarView: View {
    fileprivate func dateFromString(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: date)!
    }
    
    var body: some View {
        NavigationView {
            VStack {
                MonthView(date: Date())
                Spacer()
            }
            .navigationBarTitle(Text("September"))
            .navigationBarItems(leading: Text("Cancel"), trailing: Text("Add"))
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarView()
                .preferredColorScheme(.dark)
            
            CalendarView()
        }
    }
}

struct DayView: View {
    let date: Date
    var body: some View {
        Text(String(date.day)).frame(maxWidth: .infinity)
    }
}
