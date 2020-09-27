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
        let region = Region(calendar: Calendars.chinese, zone: Zones.asiaJakarta)
        let lunarDate = date.convertTo(region: region)
        self.date = lunarDate.dateAt(.startOfMonth).date.dateAt(.startOfWeek)
    }

    var body: some View {
        VStack {
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
    }
}
