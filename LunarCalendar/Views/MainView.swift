//
//  CalendarView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/26/20.
//

import SwiftUI
import SwiftDate

struct MainView: View {
    @State var settingModal = false
    @State var dateInRegion: DateInRegion = Date().convertTo(
        region: Region(
            calendar: Calendars.chinese,
            zone: Zones.current, locale: Locales.current
        )
    )
    
    var body: some View {
        VStack {
            CalendarView(
                dateInRegion: dateInRegion,
                dateAction: { date in
                    dateInRegion = date
                },
                prevAction: {
                    withAnimation {
                        dateInRegion = dateInRegion.dateByAdding(-1, .month)
                    }
                },
                nextAction: {
                    withAnimation {
                        dateInRegion = dateInRegion.dateByAdding(1, .month)
                    }
                }
            )
        }.toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Today") {
                    withAnimation {
                        dateInRegion = Date().convertTo(
                            region: Region(
                                calendar: Calendars.chinese,
                                zone: Zones.current, locale: Locales.current
                            )
                        )
                    }
                }
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
