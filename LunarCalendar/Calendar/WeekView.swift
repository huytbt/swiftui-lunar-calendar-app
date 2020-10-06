//
//  WeekView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/27/20.
//

import SwiftUI
import SwiftDate

struct WeekView: View {
    let date: DateInRegion
    var selectedDate: DateInRegion? = nil
    var hideItems: [Int]? = []
    var onTap: ((DateInRegion) -> Void)? = nil
    
    init(date: DateInRegion, selectedDate: DateInRegion? = nil, hideItems: [Int]? = [], onTap: ((DateInRegion) -> Void)? = nil) {
        self.date = date.dateAt(.startOfWeek)
        self.selectedDate = selectedDate
        self.hideItems = hideItems
        self.onTap = onTap
    }

    fileprivate func dateViewByIndex(_ index: Int) -> DateView {
        let date = self.date.dateByAdding(index, .day)
        return DateView(
            date: date,
            selected: selectedDate?.day == date.day && selectedDate?.month == date.month && selectedDate?.year == date.year,
            onTap: onTap
        )
    }
    
    var body: some View {
        HStack {
            ForEach(0 ..< 7) { index in
                if hideItems?.firstIndex(of: index) ?? -1 >= 0 {
                    Text("").frame(maxWidth: .infinity)
                } else {
                    dateViewByIndex(index)
                }
            }
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            WeekView(date: Date().convertTo(region: .current)).padding()
            WeekView(date: Date().convertTo(region: .current), hideItems: [0, 1, 6]).padding()
            WeekView(date: Date().convertTo(region: .current), selectedDate: Date().convertTo(region: .current)).padding()
            WeekView(date: Date().convertTo(region: .current), selectedDate: Date().dateByAdding(1, .day)).padding()
            WeekView(date: Date().convertTo(region: .current), selectedDate: Date().dateByAdding(-1, .day)).padding()
        }
        VStack{
            WeekView(date: Date().convertTo(region: .current)).padding()
            WeekView(date: Date().convertTo(region: .current), selectedDate: Date().convertTo(region: .current)).padding()
            WeekView(date: Date().convertTo(region: .current), selectedDate: Date().dateByAdding(1, .day)).padding()
            WeekView(date: Date().convertTo(region: .current), selectedDate: Date().dateByAdding(-1, .day)).padding()
        }.preferredColorScheme(.dark)
    }
}
