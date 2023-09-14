//
//  MonthView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/27/20.
//

import SwiftUI
import SwiftDate

struct MonthView: View {
    private var viewDate: DateInRegion
    private var selectedDate: DateInRegion?
    private var dateAction: ((DateInRegion) -> Void)? = nil
    private var weeks: Int = 5
    private var hideBeforeItems: [Int] = []
    private var hideAfterItems: [Int] = []
    private var startDate: DateInRegion
    
    init(viewDate: DateInRegion, selectedDate: DateInRegion? = nil, dateAction: ((DateInRegion) -> Void)? = nil) {
        self.viewDate = viewDate
        self.selectedDate = selectedDate
        self.dateAction = dateAction
        
        self.startDate = viewDate.dateAtStartOf(.month).dateAtStartOf(.weekday).dateByAdding(1, .day)

        let startDayOfMonth = viewDate.dateAtStartOf(.month).dateByAdding(1, .day).date
        let startDayOfWeekOfMonth = startDayOfMonth.dateAtStartOf(.weekOfMonth)
        if (startDayOfMonth - startDayOfWeekOfMonth).day! > 0 {
            for index in 0...((startDayOfMonth - startDayOfWeekOfMonth).day! - 1) {
                self.hideBeforeItems.append(index)
            }
        }
        let endDayOfMonth = viewDate.dateAtEndOf(.month).date
        let firstDayOfLastWeekOfMonth = endDayOfMonth.dateAtStartOf(.weekOfMonth)
        let duration = firstDayOfLastWeekOfMonth - startDayOfWeekOfMonth
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
            ForEach(0 ..< weeks, id: \.self) { index in
                Divider()
                if index == 0 {
                    WeekView(
                        viewDate: startDate.dateByAdding(index * 7, .day),
                        selectedDate: selectedDate,
                        hideItems: hideBeforeItems,
                        dateAction: dateAction
                    ).padding(.vertical)
                } else if index < weeks - 1 {
                    WeekView(
                        viewDate: startDate.dateByAdding(index * 7, .day),
                        selectedDate: selectedDate,
                        dateAction: dateAction
                    ).padding(.vertical)
                } else {
                    WeekView(
                        viewDate: startDate.dateByAdding(index * 7, .day),
                        selectedDate: selectedDate,
                        hideItems: hideAfterItems,
                        dateAction: dateAction
                    ).padding(.vertical)
                }
            }
        }
    }
}

struct MonthView_Previews: PreviewProvider {
    static let region: Region = Region(calendar: Calendars.chinese,zone: Zones.current, locale: Locales.vietnamese)
    static var previews: some View {
        MonthView(viewDate: Date().convertTo(region: region))
        MonthView(viewDate: "2045-01-01".toDate()!.convertTo(region: region))
    }
}
