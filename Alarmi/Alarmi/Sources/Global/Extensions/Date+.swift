//
//  Date+.swift
//  Alarmi
//
//  Created by Woody on 2022/07/31.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation
import UIKit

extension Date {

    enum TimeType: String {
        case _12HTime = "hh:mm"
        case _24HTime = "HH:mm"
    }

    /**
     # dateTo24HTimeString
     date를 24시간 시각 String 반환해줍니다.
     - Parameters:
       - format: 변형할 DateFormat / Date 타입
     */
    func date2TimeString() -> String {
        return Formatter.HHMMCurrentDateFormatter.string(from: self)
    }

    /**
     # contains1stDayOfMonth
     1일이면 true, 아니면 false를 반환합니다.
     */
    func contains1stDayOfMonth() -> Bool {
        let day = Int(Formatter.ddCurrentDateFormatter.string(from: self)) ?? 0
        return day == 1
    }

    /**
     # getMonthString
     1월, 2월, ... n월을 반환합니다.
     */
    func getMonthString() -> String {
        return Formatter.MMCurrentDateFormatter.string(from: self)
    }
    
    /**
     # getTodayWeekend
     오늘 요일을 반환합니다.
     - Note: 1 ~ 7은 일요일 ~ 토요일을 의미합니다. 즉 목요일일 경우, 5입니다.
     */
    func getTodayWeekend() -> Int {
        let weekday = Calendar.current.dateComponents([.weekday], from: self).weekday ?? 0
        return weekday
    }

    /**
     # before
     현재 날짜의 n일 이전 날짜를 반환합니다.
     - Parameters:
      - day: n일
     */
    func before(day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -day, to: self)!
    }
}

extension Date {

    private var sleepingTime: Int { 0 }
    private var workingTime: Int { 8 }
    private var callTime: Int { 18 }

    // MARK: 시간 알고리즘 필요합니다.
    func judgeKoreaState() -> KoreaParentState {
        let nowHour = Int(Formatter.HHKoreaDateFormatter.string(from: self))!
        if nowHour >= 0 && (sleepingTime..<workingTime).contains(nowHour) {
            return .sleeping
        } else if (workingTime..<callTime).contains(nowHour) {
            return .working
        } else {
            return .canCall
        }
    }
}

extension Date {

    func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        calendar.dateComponents([component], from: self, to: date).value(for: component)
    }

    func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
        let days1 = calendar.component(component, from: self)
        let days2 = calendar.component(component, from: date)
        return days1 - days2
    }

    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        distance(from: date, only: component) == 0
    }
}
