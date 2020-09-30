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
    var hasEvents: Bool? = false
    var onTap: ((Date) -> Void)? = nil

    var body: some View {
        VStack {
            if selected! {
                if date.isToday {
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
                if date.isToday {
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
        let date: Date
        var color: Color? = nil
        var onTap: ((Date) -> Void)? = nil

        fileprivate func lunarDate(date: Date) -> DateInRegion {
            let region = Region(calendar: Calendars.chinese)
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
            .gesture(
                TapGesture().onEnded {
                    if onTap != nil {
                        onTap!(date)
                    }
                }
            )
        }
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DateView(date: Date()).padding()
            DateView(date: Date(), selected: true).padding()
            DateView(date: "2045-01-01".toDate()!.date, hasEvents: true).padding()
            DateView(date: "2020-01-01".toDate()!.date, selected: true).padding()
        }
        VStack {
            DateView(date: Date()).padding()
            DateView(date: Date(), selected: true).padding()
            DateView(date: "2045-01-01".toDate()!.date, hasEvents: true).padding()
            DateView(date: "2020-01-01".toDate()!.date, selected: true).padding()
        }.preferredColorScheme(.dark)
    }
}
