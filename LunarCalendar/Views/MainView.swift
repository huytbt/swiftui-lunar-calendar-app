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
            zone: Zones.current,
            locale: Locales.current
        )
    )
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                CalendarView(
                    dateInRegion: dateInRegion,
                    dateAction: { date in
                        dateInRegion = date
                    }
                ).onAppear {
                    withAnimation {
                        proxy.scrollTo("selectedDate", anchor: .trailing)
                    }
                }
            }.toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Today") {
                        withAnimation {
                            dateInRegion = Date().convertTo(
                                region: Region(
                                    calendar: Calendars.chinese,
                                    zone: Zones.current,
                                    locale: Locales.current
                                )
                            )
                            proxy.scrollTo("selectedDate", anchor: .trailing)
                        }
                    }
                    Spacer()
                    HStack {
                        Button(action: {
                            withAnimation {
                                dateInRegion = dateInRegion.dateByAdding(-1, .month)
                                proxy.scrollTo("selectedDate", anchor: .trailing)
                            }
                        }) {
                            Image(systemName: "chevron.left")
                        }
                        Button(action: {
                            withAnimation {
                                dateInRegion = dateInRegion.dateByAdding(1, .month)
                                proxy.scrollTo("selectedDate", anchor: .trailing)
                            }
                        }) {
                            Image(systemName: "chevron.right")
                        }
                    }
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
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .preferredColorScheme(.dark)
        }
    }
}
