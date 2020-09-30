//
//  MonthView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/27/20.
//

import SwiftUI
import SwiftDate

struct MonthView: View {
    let date: Date
    
    init(date: Date) {
        let region = Region(calendar: Calendars.chinese)
        let lunarDate = date.convertTo(region: region)
        self.date = lunarDate.dateAtStartOf(.month).date.dateAtStartOf(.weekday)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(date.toFormat("MMM yyyy"))
                .font(.title3)
                .padding()
            ForEach(0 ..< 5) { index in
                WeekView(date: date.dateByAdding(index * 7, .day).date)
                    .padding(.vertical)
            }
        }
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(date: Date())
        MonthView(date: "2045-01-01".toDate()!.date)
    }
}
