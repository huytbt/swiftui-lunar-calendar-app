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
    
    init(date: Date, selectedDate: Date? = nil) {
        self.date = date.dateAt(.startOfWeek)
        self.selectedDate = selectedDate
    }

    fileprivate func dateViewByIndex(_ index: Int) -> DateView {
        let date = self.date.dateByAdding(index, .day).date
        return DateView(
            date: date,
            selected: selectedDate?.compare(toDate: date, granularity: .day) == .orderedSame
        )
    }
    
    var body: some View {
        HStack {
            ForEach(0 ..< 7) { index in
                dateViewByIndex(index)
            }
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            WeekView(date: Date()).padding()
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
