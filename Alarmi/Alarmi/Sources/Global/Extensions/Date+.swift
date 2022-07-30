//
//  Date+.swift
//  Alarmi
//
//  Created by Woody on 2022/07/31.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

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
       - type: 12시간제, 24시간제
     */
    func date2TimeString(_ format: Date, type: TimeType) -> String {
        DateManager.shared.dateFormatter.dateFormat = type.rawValue
        return DateManager.shared.dateFormatter.string(from: format)
    }

    /**
     # contains1stDayOfMonth
     1일이면 true, 아니면 false를 반환합니다.
     */
    func contains1stDayOfMonth() -> Bool {
        DateManager.shared.dateFormatter.dateFormat = "dd"
        let day = Int(DateManager.shared.dateFormatter.string(from: self)) ?? 0
        return day == 1
    }

    /**
     # getMonthString
     1월, 2월, ... n월을 반환합니다.
     */
    func getMonthString() -> String {
        DateManager.shared.dateFormatter.dateFormat = "M월"
        return DateManager.shared.dateFormatter.string(from: self)
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
    func before(day: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: -day, to: self)
    }
}
