//
//  DateView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/27/20.
//

import SwiftUI
import SwiftDate

struct DateView: View {
    let date: DateInRegion
    var selected: Bool? = false
    var hasEvents: Bool? = false
    var onTap: ((DateInRegion) -> Void)? = nil
    
    fileprivate func isToday(date: DateInRegion) -> Bool {
        let region = Region(calendar: Calendars.gregorian, zone: Zones.current)
        let today = Date().convertTo(region: region)
        return today.day == date.day && today.month == date.month && today.year == date.year
    }

    var body: some View {
        VStack {
            if selected! {
                if isToday(date: date) {
                    DateText(date: date, color: Color.white, onTap: onTap)
                        .background(
                            Circle()
                                .foregroundColor(Color(UIColor.systemRed))
                                .frame(minWidth: 50, minHeight: 50)
                        )
                } else {
                    DateText(date: date, color: Color(UIColor.systemBackground), onTap: onTap)
                        .background(
                            Circle()
                                .foregroundColor(Color(UIColor.label))
                                .frame(minWidth: 50, minHeight: 50)
                        )
                }
            } else {
                if isToday(date: date) {
                    DateText(date: date, color: Color(UIColor.systemRed), onTap: onTap)
                } else {
                    DateText(date: date, onTap: onTap)
                }
            }
            if hasEvents! {
                Circle()
                    .foregroundColor(Color(UIColor.systemGray2))
                    .frame(width: 8, height: 8)
            } else {
                Circle()
                    .frame(width: 8, height: 8)
                    .opacity(0.0)
            }
        }
    }
    
    struct DateText: View {
        let date: DateInRegion
        var color: Color? = nil
        var onTap: ((DateInRegion) -> Void)? = nil

        fileprivate func lunarDate(date: DateInRegion) -> DateInRegion {
            let region = Region(calendar: Calendars.chinese, zone: Zones.current)
            return date.convertTo(region: region)
        }

        var body: some View {
            VStack {
                if color != nil {
                    Text(String(date.day) + (date.day == 1 ? "/\(date.month)" : ""))
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
            .onTapGesture {
                if onTap != nil {
                    onTap!(date)
                }
            }
        }
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DateView(date: Date().convertTo(region: .current)).padding()
            DateView(date: Date().convertTo(region: .current), selected: true).padding()
            DateView(date: "2045-01-01".toDate()!, hasEvents: true).padding()
            DateView(date: "2020-01-01".toDate()!, selected: true).padding()
        }
        VStack {
            DateView(date: Date().convertTo(region: .current)).padding()
            DateView(date: Date().convertTo(region: .current), selected: true).padding()
            DateView(date: "2045-01-01".toDate()!, hasEvents: true).padding()
            DateView(date: "2020-01-01".toDate()!, selected: true).padding()
        }.preferredColorScheme(.dark)
    }
}
