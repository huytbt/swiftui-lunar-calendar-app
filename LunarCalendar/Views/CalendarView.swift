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
                        ForEach(0...(midIndex * 2), id: \.self) { i in
                            MonthView(date: Date().dateByAdding(i - midIndex, .month).date)
                                .navigationTitle(Date().dateByAdding(i, .month).date.toFormat("MMMM yyyy"))
                        }
                    }
                    .onAppear {
                        withAnimation {
                            scrollView.scrollTo(midIndex)
                        }
                    }
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

            CalendarView()
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
