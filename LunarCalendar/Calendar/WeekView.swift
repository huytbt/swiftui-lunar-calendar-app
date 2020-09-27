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
    
    init(date: Date) {
        self.date = date.dateAt(.startOfWeek)
    }

    var body: some View {
        HStack {
            ForEach(0 ..< 7) { index in
                DateView(date: date.dateByAdding(index, .day).date)
            }
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView(date: Date())
    }
}
