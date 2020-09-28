//
//  CalendarView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/26/20.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            ScrollViewReader { scrollView in
                LazyVStack(spacing: 10) {
                    ForEach(1...1000, id: \.self) { i in
                        MonthView(date: Date().dateByAdding(i, .month).date)
                    }
                }
                .onAppear {
                    scrollView.scrollTo(500)
                }
            }
        }
//        List(0..<1000) { i in
//            MonthView(date: Date().dateByAdding(i, .month).date)
//        }
//        ScrollView {
//            ScrollViewReader { value in
//                Button("Jump to #8") {
//                    value.scrollTo(5)
//                }
//
//                ForEach(0..<10) { i in
//                    MonthView(date: Date().dateByAdding(i, .month).date)
//                }
//            }
//        }
//        NavigationView {
//            VStack {
//                MonthView(date: Date())
//                Spacer()
//            }
//            .navigationBarTitle(Text("September"))
//            .navigationBarItems(leading: Text("Cancel"), trailing: Text("Add"))
//        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarView()
                .preferredColorScheme(.dark)
            
            // CalendarView()
        }
    }
}
