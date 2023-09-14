//
//  CalendarScrollView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 10/16/20.
//

import SwiftUI
import SwiftDate

struct CalendarScrollView: View {
    var selectedDate: DateInRegion? = nil {
        didSet {
            withAnimation {
                scrollView!.scrollTo(midIndex, anchor: .top)
            }
        }
    }
    var onTap: ((DateInRegion) -> Void)? = nil
    private let midIndex = 100 // Date().year * 12 + Date().month
    private let scrollView: ScrollViewProxy? = nil

    var body: some View {
        ScrollView(showsIndicators: false) {
            ScrollViewReader { scrollView in
                LazyVStack() {
                    ForEach(0...(midIndex * 2), id: \.self) { index in
                        MonthView(
                            viewDate: Date()
                                .dateByAdding(
                                    Int(floor(29.530588853 * Double(index - midIndex))),
                                    .day
                                ),
                            selectedDate: selectedDate,
                            dateAction: onTap
                        )
                    }
                }.onAppear {
//                    withAnimation {
                        scrollView.scrollTo(midIndex, anchor: .top)
//                    }
                }
            }
        }
    }
}

struct CalendarScrollView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScrollView()
    }
}
