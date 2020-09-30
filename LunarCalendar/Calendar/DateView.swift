//
//  DateView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/27/20.
//

import SwiftUI
import SwiftDate

struct DateView: View {
    let date: Date
    var selected: Bool? = false
    var body: some View {
        if selected ?? false {
            if date.isToday {
                DateText(date: date, color: Color.white)
                    .background(
                        Circle()
                            .foregroundColor(Color.red)
                            .frame(minWidth: 50, minHeight: 50)
                    )
            } else {
                DateText(date: date, color: Color(UIColor.systemBackground))
                    .background(
                        Circle()
                            .foregroundColor(Color(UIColor.label))
                            .frame(minWidth: 50, minHeight: 50)
                    )
            }
        } else {
            if date.isToday {
                DateText(date: date, color: Color.red)
            } else {
                DateText(date: date)
            }
        }
    }
    
    struct DateText: View {
        let date: Date
        var color: Color? = nil
        fileprivate func lunarDate(date: Date) -> DateInRegion {
            let region = Region(calendar: Calendars.chinese)
            return date.convertTo(region: region)
        }
        var body: some View {
            VStack {
                if color != nil {
                    Text(String(date.day))
                        .foregroundColor(color)
                        .frame(maxWidth: .infinity)
                    Text(String(lunarDate(date: date).day))
                        .foregroundColor(color)
                        .font(.caption)
                } else {
                    Text(String(date.day) + (date.day == 1 ? "/\(date.month)" : ""))
                        .frame(maxWidth: .infinity)
                    Text(String(lunarDate(date: date).day))
                        .font(.caption)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DateView(date: Date()).padding()
            DateView(date: Date(), selected: true).padding()
            DateView(date: "2045-01-01".toDate()!.date).padding()
            DateView(date: "2020-01-01".toDate()!.date, selected: true).padding()
        }
        VStack {
            DateView(date: Date()).padding()
            DateView(date: Date(), selected: true).padding()
            DateView(date: "2045-01-01".toDate()!.date).padding()
            DateView(date: "2020-01-01".toDate()!.date, selected: true).padding()
        }.preferredColorScheme(.dark)
    }
}
