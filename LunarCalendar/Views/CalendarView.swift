//
//  CalendarView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/26/20.
//

import SwiftUI

struct CalendarView: View {
    fileprivate func dateFromString(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: date)!
    }
    
    var body: some View {
        NavigationView {
            List {
                VStack {
                    Text("September")
                        .font(.title)
                        .padding(.bottom)
                        
                        
                    HStack {
                        Text("MON").font(.caption).frame(maxWidth: .infinity)
                        Text("TUE").font(.caption).frame(maxWidth: .infinity)
                        Text("WED").font(.caption).frame(maxWidth: .infinity)
                        Text("THU").font(.caption).frame(maxWidth: .infinity)
                        Text("FRI").font(.caption).frame(maxWidth: .infinity)
                        Text("SAT").font(.caption).frame(maxWidth: .infinity)
                        Text("SUN").font(.caption).frame(maxWidth: .infinity)
                    }
                    .padding(.bottom)
                    
                    HStack {
                        DayView(date: dateFromString(date: "2020-09-28"))
                        DayView(date: dateFromString(date: "2020-09-29"))
                        DayView(date: dateFromString(date: "2020-09-30"))
                        DayView(date: dateFromString(date: "2020-10-01"))
                        DayView(date: dateFromString(date: "2020-10-02"))
                        DayView(date: dateFromString(date: "2020-10-03"))
                        DayView(date: dateFromString(date: "2020-10-04"))
                    }
                    .padding(.bottom)
                    
                    HStack {
                        DayView(date: dateFromString(date: "2020-10-05"))
                        DayView(date: dateFromString(date: "2020-10-06"))
                        DayView(date: dateFromString(date: "2020-10-07"))
                        DayView(date: dateFromString(date: "2020-10-08"))
                        DayView(date: dateFromString(date: "2020-10-09"))
                        DayView(date: dateFromString(date: "2020-10-10"))
                        DayView(date: dateFromString(date: "2020-10-11"))
                    }
                    .padding(.bottom)
                }
            }
            .navigationBarTitle(Text("Lunar Calendar"))
            .navigationBarItems(leading: Text("Cancel"), trailing: Text("Add"))
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

struct DayView: View {
    let date: Date
    var body: some View {
        Text(String(date.day)).frame(maxWidth: .infinity)
    }
}
