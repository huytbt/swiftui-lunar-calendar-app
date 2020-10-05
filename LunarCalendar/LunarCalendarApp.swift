//
//  LunarCalendarApp.swift
//  LunarCalendar
//
//  Created by Huy Ta on 10/5/20.
//

import SwiftUI

@main
struct LunarCalendarApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            CalendarView()
        }
    }
}
