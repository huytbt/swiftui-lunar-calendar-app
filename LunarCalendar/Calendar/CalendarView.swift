//
//  CalendarView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/26/20.
//

import SwiftUI
import SwiftDate

struct CalendarView: View {
    var dateInRegion: DateInRegion
    var dateAction: ((DateInRegion) -> Void)? = nil
    var plusAction: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(dateInRegion.toFormat("LLLL").capitalized)
                    Text(dateInRegion.toFormat("UUUU").capitalized + "/" + dateInRegion.date.toFormat("YYYY")).font(.caption)
                }
                Spacer()
                Button(action: {
                    plusAction?()
                }) {
                    Image(systemName: "plus").frame(width: 44, height: 44, alignment: .trailing)
                }
            }.padding()
            WeekdayLabel(dateInRegion: dateInRegion)
            ScrollView() {
                MonthView(
                    viewDate: dateInRegion,
                    selectedDate: dateInRegion,
                    dateAction: dateAction
                )
            }
        }
    }
}

struct WeekdayLabel: View {
    var dateInRegion: DateInRegion
    var body: some View {
        HStack {
            ForEach(0 ..< 7) { index in
                Text(Date().dateAt(.startOfWeek).dateByAdding(index, .day).convertTo(region: dateInRegion.region).weekdayName(.short).capitalized)
                    .font(.caption)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static let region: Region = Region(calendar: Calendars.chinese,zone: Zones.current, locale: Locales.vietnamese)
    static var previews: some View {
        Group {
            CalendarView(dateInRegion: Date().convertTo(region: region))
                .preferredColorScheme(.dark)
        }
    }
}
