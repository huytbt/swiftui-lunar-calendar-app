//
//  CalendarView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/26/20.
//

import SwiftUI
import SwiftDate

struct CalendarView: View {
    private let midIndex = Date().year * 12 + Date().month
    var body: some View {
        VStack {
            WeekdayLabel()
            ScrollView(showsIndicators: false) {
                ScrollViewReader { scrollView in
                    LazyVStack(spacing: 10) {
                        ForEach(0...(midIndex * 2), id: \.self) { index in
                            MonthView(
                                date: Date()
                                    .dateByAdding(
                                        Int(floor(29.530588853 * Double((index - midIndex)))
                                    ), .day).date
                            )
                        }
                    }.onAppear {
                        withAnimation {
                            scrollView.scrollTo(midIndex)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Today") {}
                    Spacer()
                    Button("Events") {}
                    Spacer()
                    Button("Settings") {}
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
