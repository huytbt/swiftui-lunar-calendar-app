//
//  MonthView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/27/20.
//

import SwiftUI
import SwiftDate

struct MonthView: View {
    private let date: Date
    var selectedDate: DateInRegion? = nil
    var onTap: ((DateInRegion) -> Void)? = nil
    private var weeks: Int = 5
    private var hideBeforeItems: [Int] = []
    private var hideAfterItems: [Int] = []
    
    init(date: DateInRegion, selectedDate: DateInRegion? = nil, onTap: ((DateInRegion) -> Void)? = nil) {
        self.selectedDate = selectedDate
        self.onTap = onTap
        let region = Region(calendar: Calendars.chinese)
        let lunarDate = date.convertTo(region: region)
        let startDayOfMonth = lunarDate.dateAtStartOf(.month).date
        self.date = startDayOfMonth.dateAtStartOf(.weekOfMonth)
        if (startDayOfMonth - self.date).day! > 0 {
            for index in 0...((startDayOfMonth - self.date).day! - 1) {
                self.hideBeforeItems.append(index)
            }
        }
        let endDayOfMonth = lunarDate.dateAtEndOf(.month).date
        let firstDayOfWeekOfMonth = endDayOfMonth.dateAtStartOf(.weekOfMonth)
        let duration = firstDayOfWeekOfMonth - self.date
        if duration.weekOfYear! != 4 && duration.day! > 0 {
            weeks = 6
        }
        let endDayOfWeekOfMonth = endDayOfMonth.dateAtEndOf(.weekOfMonth)
        if (endDayOfWeekOfMonth - endDayOfMonth).day! > 0 {
            for index in 0...((endDayOfWeekOfMonth - endDayOfMonth).day!) {
                self.hideAfterItems.append(7 - index)
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(date.toFormat("MMM yyyy"))
                .font(.title3)
                .padding()
            ForEach(0 ..< weeks, id: \.self) { index in
                if index == 0 {
                    WeekView(
                        date: date.dateByAdding(index * 7, .day),
                        selectedDate: selectedDate,
                        hideItems: hideBeforeItems,
                        onTap: onTap
                    ).padding(.vertical)
                } else if index < weeks - 1 {
                    WeekView(
                        date: date.dateByAdding(index * 7, .day),
                        selectedDate: selectedDate,
                        onTap: onTap
                    ).padding(.vertical)
                } else {
                    WeekView(
                        date: date.dateByAdding(index * 7, .day),
                        selectedDate: selectedDate,
                        hideItems: hideAfterItems,
                        onTap: onTap
                    ).padding(.vertical)
                }
            }
        }
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(date: Date().convertTo(region: .current))
        MonthView(date: "2045-01-01".toDate()!)
    }
}
