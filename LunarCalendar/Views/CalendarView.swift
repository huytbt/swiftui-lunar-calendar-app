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
    @State private var scrollView: ScrollViewProxy? = nil
    private let midIndex = Date().year * 12 + Date().month
    
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
                ScrollView(showsIndicators: false) {
                    ScrollViewReader { scrollView in
                        LazyVStack() {
                            ForEach(0...(midIndex * 2), id: \.self) { index in
                                MonthView(
                                    date: Date()
                                        .dateByAdding(
                                            Int(floor(29.530588853 * Double(index - midIndex))),
                                            .day
                                        ),
                                    selectedDate: selectedDate,
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
                        }.onAppear {
                            if self.scrollView == nil {
                                self.scrollView = scrollView
                            }
                            withAnimation {
                                scrollView.scrollTo(midIndex, anchor: .top)
                            }
                        }
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
                        self.scrollView?.scrollTo(midIndex, anchor: .top)
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
