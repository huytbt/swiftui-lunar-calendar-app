//
//  CalendarView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/26/20.
//

import SwiftUI
import SwiftDate

struct CalendarView: View {
    @State private var isShowingEvent = false
    @State private var selectedDate: DateInRegion = Date().convertTo(region: .current)
    @State private var settingModal = false
    @State private var calendarKey: UInt8 = 0
    
    var body: some View {
        TabView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("September")
                        Text("2020").font(.caption)
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                }.padding()
                WeekdayLabel()
                ForEach(0...1, id: \.self) { index in
                    if index == calendarKey {
                        CalendarScrollView(
                            selectedDate: self.selectedDate,
                            onTap: { date in
                                withAnimation {
                                    if self.selectedDate == date {
                                        self.isShowingEvent.toggle()
                                    } else {
                                        self.isShowingEvent = true
                                    }
                                    self.selectedDate = date
                                }
                            }
                        )
                    }
                }
                if isShowingEvent {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Today").font(.headline)
                            Text("3 Events").font(.caption)
                        }.padding()
                        List {
                            Text("Mon's birthday")
                            Text("Review design")
                            Text("Deployment")
                        }
                    }.frame(height: 300)
                }
            }
        }.toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Today") {
                    withAnimation {
                        self.selectedDate = Date().convertTo(region: .current)
                        self.calendarKey = self.calendarKey == 1 ? 0 : 1
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
    
    struct WeekdayLabel: View {
        var body: some View {
            HStack{
                ForEach(0 ..< 7) { index in
                    Text(Date().dateAt(.startOfWeek).dateByAdding(index, .day).weekdayName(.short))
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarView()
                .preferredColorScheme(.dark)
        }
    }
}
