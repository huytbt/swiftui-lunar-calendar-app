//
//  DateView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/27/20.
//

import SwiftUI
import SwiftDate

struct DateView: View {
    let date: Date
    fileprivate func lunarDate(date: Date) -> DateInRegion {
        let lunar = Region(calendar: Calendars.chinese, zone: Zones.asiaJakarta)
        return date.convertTo(region: lunar)
    }
    
    var body: some View {
        VStack {
            Text(String(date.day))
            Text(String(lunarDate(date: date).day))
                .font(.caption)
        }.frame(maxWidth: .infinity)
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(date: Date())
    }
}
