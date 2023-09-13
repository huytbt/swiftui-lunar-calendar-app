//
//  CalendarView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/26/20.
//

import SwiftUI
import SwiftDate

struct CalendarView: View {
    @State private var dateInRegion: DateInRegion
    
    init(date: Date, region: Region) {
        _dateInRegion = State(initialValue: date.convertTo(region: region))
    }
    
    var body: some View {
        VStack {
            HStack {
                    VStack(alignment: .leading) {
                        Text(dateInRegion.toFormat("LLLL").capitalized)
                        Text(dateInRegion.toFormat("UUUU").capitalized + "/" + dateInRegion.date.toFormat("YYYY")).font(.caption)
                    }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }.padding()
            WeekdayLabel(dateInRegion: dateInRegion)
            ScrollView() {
                MonthView(
                    viewDate: dateInRegion,
                    selectedDate: dateInRegion,
                    onTap: { date in
                        dateInRegion = date
                    }
                ).gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded { value in
                        if value.translation.width < 0 {
                            withAnimation {
                                dateInRegion = dateInRegion.dateByAdding(1, .month)
                            }
                        }
                        if value.translation.width > 0 {
                            withAnimation {
                                dateInRegion = dateInRegion.dateByAdding(-1, .month)
                            }
                        }
                    }
                )
            }
        }
    }
}

struct WeekdayLabel: View {
    var dateInRegion: DateInRegion
    var body: some View {
        HStack{
            ForEach(0 ..< 7) { index in
                Text(Date().dateAt(.startOfWeek).dateByAdding(index, .day).convertTo(region: dateInRegion.region).weekdayName(.short).capitalized)
                    .font(.caption)
                    .frame(maxWidth: .infinity)
            }
        }.padding(.horizontal, 5)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static let region: Region = Region(calendar: Calendars.chinese,zone: Zones.current, locale: Locales.vietnamese)
    static var previews: some View {
        Group {
            CalendarView(date: Date(), region: region)
                .preferredColorScheme(.dark)
        }
    }
}
