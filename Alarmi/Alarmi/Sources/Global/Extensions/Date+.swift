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

    func after(day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: self)!
    }
}

extension Date {

    private var sleepingTimeHour: Int { 0 }
    private var awakingTimeHour: Int { 7 }
    static var defaultCallStartTime: String { "18:30" }
    static var defaultCallEndTime: String { "23:30" }

    static var koreanDefulatCallStartTimeCurrentDate: Date {
        let koreaDate = Calendar.current.date(from: DateComponents.koreaTime(defaultCallStartTime))!
        let currentDateString = Formatter.YYYYMMddHHmmCurrentDateFormatter.string(from: koreaDate)
        return Formatter.YYYYMMddHHmmCurrentDateFormatter.date(from: currentDateString)!
    }

    static var koreanDefulatCallEndTimeCurrentDate: Date {
        let koreaDate = Calendar.current.date(from: DateComponents.koreaTime(defaultCallEndTime))!
        let currentDateString = Formatter.YYYYMMddHHmmCurrentDateFormatter.string(from: koreaDate)
        return Formatter.YYYYMMddHHmmCurrentDateFormatter.date(from: currentDateString)!
    }

    private var koreanSleepingTimeCurrentDate: Date {
        let koreaDate = Calendar.current.date(from: DateComponents.koreaHour(sleepingTimeHour))!
        let currentDateString = Formatter.YYYYMMddHHmmCurrentDateFormatter.string(from: koreaDate)
        return Formatter.YYYYMMddHHmmCurrentDateFormatter.date(from: currentDateString)!
    }

    private var koreanAwakingTimeCurrentDate: Date {
        let koreaDate = Calendar.current.date(from: DateComponents.koreaHour(awakingTimeHour))!
        let currentDateString = Formatter.YYYYMMddHHmmCurrentDateFormatter.string(from: koreaDate)
        return Formatter.YYYYMMddHHmmCurrentDateFormatter.date(from: currentDateString)!
    }

    private var callStartTimeDate: Date {
        guard let callTime = CallTimeUserDefaults(key: .callTime).data else {
            return Date()
        }
        return Calendar.current.date(from: DateComponents.convertTime(callTime.start))!
    }

    private var callEndTimeDate: Date {
        guard let callTime = CallTimeUserDefaults(key: .callTime).data else {
            return Date()
        }
        return Calendar.current.date(from: DateComponents.convertTime(callTime.end))!
    }

    func judgeKoreaState() -> KoreaParentState {

        /*
         1. sleep 시간 확인
           -  맞다: dark + 이미지/텍스트 = "자고있느 ㄴ시간이에요"
           -  아니다: light + 이미지/텍스트 = "전화가능시간이 아니에요"

         2. callTime
          - 맞다: 이미지 텍스트
          - 아니면: 나가기
         */

        if koreanSleepingTimeCurrentDate.timeIntervalSinceNow <= 0 &&
            koreanAwakingTimeCurrentDate.timeIntervalSinceNow >= 0 {
            if callStartTimeDate.isInPast &&
                callEndTimeDate.isInFuture {
                return .canCallDark
            } else {
                return .sleeping
            }
        } else {
            if callStartTimeDate.isInPast &&
                callEndTimeDate.isInFuture {
                return .canCallLight
            } else {
                return .working
            }
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
