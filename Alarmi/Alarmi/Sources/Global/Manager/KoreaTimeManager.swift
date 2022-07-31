//
//  KoreaTimeManager.swift
//  Alarmi
//
//  Created by Woody on 2022/07/31.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

final class KoreaTimeManager {
    private init() {}

    static let shared = KoreaTimeManager()

    private let midNightTime: Int = 0
    private let awakeTime: Int = 7

    func getTodayMidNightTime() -> Date {
        return Calendar.current.date(
            bySettingHour: convertKoreaTimeToCurrentCountryTime(koreaHour: self.midNightTime),
            minute: 0,
            second: 0,
            of: Date()
        )!
    }

    func getTodayAwakeTime() -> Date {
        return Calendar.current.date(
            bySettingHour: convertKoreaTimeToCurrentCountryTime(koreaHour: self.awakeTime),
            minute: 0,
            second: 0,
            of: Date()
        )!
    }

}

extension KoreaTimeManager {

    private func convertKoreaTimeToCurrentCountryTime(koreaHour hour: Int) -> Int {
        return Calendar.current.date(from: DateComponents.koreaHour(hour))
            .map { (date: Date) -> Int in
                return Int(Formatter.HHCurrentDateFormatter.string(from: date))!
            }!
    }
}
