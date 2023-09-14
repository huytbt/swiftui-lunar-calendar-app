//
//  WeekView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/27/20.
//

import SwiftUI
import SwiftDate

struct WeekView: View {
    private var viewDate: DateInRegion
    private var selectedDate: DateInRegion? = nil
    private var hideItems: [Int]? = []
    private var dateAction: ((DateInRegion) -> Void)? = nil
    
    init(viewDate: DateInRegion, selectedDate: DateInRegion? = nil, hideItems: [Int]? = [], dateAction: ((DateInRegion) -> Void)? = nil) {
        self.viewDate = viewDate.date.dateAt(.startOfWeek).convertTo(region: viewDate.region)
        self.selectedDate = selectedDate
        self.hideItems = hideItems
        self.dateAction = dateAction
    }

    fileprivate func DateViewByIndex(_ index: Int) -> DateView {
        let date = self.viewDate.dateByAdding(index, .day)
        return DateView(
            date: date,
            selected: selectedDate?.day == date.day && selectedDate?.month == date.month && selectedDate?.year == date.year,
            action: dateAction
        )
    }
    
    var body: some View {
        HStack {
            ForEach(0 ..< 7) { index in
                if hideItems?.firstIndex(of: index) ?? -1 >= 0 {
                    Text("").frame(maxWidth: .infinity)
                } else {
                    DateViewByIndex(index)
                }
            }
        }.padding(.horizontal, 5)
    }
}

struct WeekView_Previews: PreviewProvider {
    static let region: Region = Region(calendar: Calendars.chinese,zone: Zones.current, locale: Locales.vietnamese)
    static var previews: some View {
        VStack{
            WeekView(viewDate: Date().convertTo(region: region)).padding()
            WeekView(viewDate: Date().convertTo(region: region), hideItems: [0, 1, 6]).padding()
            WeekView(viewDate: Date().convertTo(region: region), selectedDate: Date().convertTo(region: region)).padding()
            WeekView(viewDate: Date().convertTo(region: region), selectedDate: Date().dateByAdding(1, .day)).padding()
            WeekView(viewDate: Date().convertTo(region: region), selectedDate: Date().dateByAdding(-1, .day)).padding()
        }
        VStack{
            WeekView(viewDate: Date().convertTo(region: region)).padding()
            WeekView(viewDate: Date().convertTo(region: region), selectedDate: Date().convertTo(region: region)).padding()
            WeekView(viewDate: Date().convertTo(region: region), selectedDate: Date().dateByAdding(1, .day)).padding()
            WeekView(viewDate: Date().convertTo(region: region), selectedDate: Date().dateByAdding(-1, .day)).padding()
        }.preferredColorScheme(.dark)
    }
}
