//
//  MonthView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/27/20.
//

import SwiftUI
import SwiftDate

struct MonthView: View {
    var viewDate: DateInRegion
    var selectedDate: DateInRegion?
    var dateAction: ((DateInRegion) -> Void)? = nil

    private var weeks: Int = 5
    private var startDate: DateInRegion
    private var lastDateOfMonth: DateInRegion
    
    init(viewDate: DateInRegion, selectedDate: DateInRegion? = nil, dateAction: ((DateInRegion) -> Void)? = nil) {
        self.viewDate = viewDate
        self.selectedDate = selectedDate
        self.dateAction = dateAction
        
        startDate = viewDate.dateAtStartOf([.month, .weekOfYear])
            .dateByAdding(viewDate.hour, .hour).dateByAdding(viewDate.minute, .minute).dateByAdding(viewDate.second, .second)
        lastDateOfMonth = viewDate.dateAtEndOf(.month)
        
        let components = lastDateOfMonth.dateAtEndOf(.weekOfYear).componentsSince(
            startDate, components: [.weekOfYear]
        )
        weeks = components.weekOfYear! + 1
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0 ..< weeks, id: \.self) { index in
                Divider()
                WeekView(
                    viewDate: startDate.dateByAdding(index, .weekOfYear),
                    selectedDate: selectedDate,
                    isOnlyShowDateOfMonth: true,
                    dateAction: dateAction
                ).padding(.vertical)
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
