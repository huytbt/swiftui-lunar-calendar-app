//
//  WeekView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/27/20.
//

import SwiftUI
import SwiftDate

struct WeekView: View {
    let date: Date
    var selectedDate: Date? = nil
    var hideItems: [Int]? = []
    var onTap: ((Date) -> Void)? = nil
    
    init(date: Date, selectedDate: Date? = nil, hideItems: [Int]? = [], onTap: ((Date) -> Void)? = nil) {
        self.date = date.dateAt(.startOfWeek)
        self.selectedDate = selectedDate
        self.hideItems = hideItems
        self.onTap = onTap
    }

    fileprivate func dateViewByIndex(_ index: Int) -> DateView {
        let date = self.date.dateByAdding(index, .day).date
        return DateView(
            date: date,
            selected: selectedDate?.compare(toDate: date, granularity: .day) == .orderedSame,
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
            WeekView(date: Date()).padding()
            WeekView(date: Date(), hideItems: [0, 1, 6]).padding()
            WeekView(date: Date(), selectedDate: Date()).padding()
            WeekView(date: Date(), selectedDate: Date().dateByAdding(1, .day).date).padding()
            WeekView(date: Date(), selectedDate: Date().dateByAdding(-1, .day).date).padding()
        }
        VStack{
            WeekView(date: Date()).padding()
            WeekView(date: Date(), selectedDate: Date()).padding()
            WeekView(date: Date(), selectedDate: Date().dateByAdding(1, .day).date).padding()
            WeekView(date: Date(), selectedDate: Date().dateByAdding(-1, .day).date).padding()
        }.preferredColorScheme(.dark)
    }
}
