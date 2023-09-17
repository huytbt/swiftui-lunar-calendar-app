//
//  WeekView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/27/20.
//

import SwiftUI
import SwiftDate

struct WeekView: View {
    var viewDate: DateInRegion
    var selectedDate: DateInRegion? = nil
    var isOnlyShowDateOfMonth: Bool? = false
    var hideItems: [Int]? = []
    var dateAction: ((DateInRegion) -> Void)? = nil
    
    var body: some View {
        HStack {
            ForEach(0 ..< 7) { index in
                DateViewOrBlank(
                    viewDate: viewDate.dateByAdding(index, .day),
                    selectedDate: selectedDate,
                    isOnlyShowDateOfMonth: isOnlyShowDateOfMonth,
                    dateAction: dateAction
                )
            }
        }.padding(.horizontal, 5)
    }
}

struct DateViewOrBlank: View {
    var viewDate: DateInRegion
    var dateAction: ((DateInRegion) -> Void)? = nil
    
    private var isBlank: Bool? = false
    private var isSelect: Bool = false
    
    init(viewDate: DateInRegion, selectedDate: DateInRegion? = nil, isOnlyShowDateOfMonth: Bool? = nil, dateAction: ((DateInRegion) -> Void)? = nil) {
        self.viewDate = viewDate
        self.dateAction = dateAction
        
        self.isSelect = selectedDate?.toFormat("YYYY-LL-dd") == viewDate.toFormat("YYYY-LL-dd")
        
        if isOnlyShowDateOfMonth ?? false && selectedDate != nil {
            isBlank = selectedDate!.toFormat("LL") != viewDate.toFormat("LL")
        }
    }
    
    var body: some View {
        if isBlank! {
            Text("").frame(maxWidth: .infinity)
        } else {
            DateView(
                date: viewDate,
                selected: isSelect,
                action: dateAction
            )
        }
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
