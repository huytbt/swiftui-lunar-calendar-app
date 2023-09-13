//
//  CalendarView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/26/20.
//

import SwiftUI
import SwiftDate

struct MainView: View {
    @State private var settingModal = false
    
    var body: some View {
        VStack {
            CalendarView(
                date: Date(),
                region: Region(calendar: Calendars.chinese, zone: Zones.current, locale: Locales.current)
            )
        }.toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Today") {}
                Spacer()
                Button("Events") {}
                Spacer()
                Button("Settings") {
                    self.settingModal.toggle()
                }.sheet(isPresented: $settingModal) {
                    SettingView(showModal: self.$settingModal)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .preferredColorScheme(.dark)
        }
    }
}
