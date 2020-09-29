//
//  LunarCalendarApp.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/26/20.
//

import SwiftUI

@main
struct LunarCalendarApp: App {
    var body: some Scene {
        WindowGroup {
            CalendarView()
        }
    }
}

struct LunarCalendarApp_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .preferredColorScheme(.dark)
    }
}
