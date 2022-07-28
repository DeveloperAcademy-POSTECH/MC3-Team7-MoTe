//
//  KoreanTimeDateManager.swift
//  Alarmi
//
//  Created by Woody on 2022/07/25.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

class TimeCalculationManager {
    private init() {}
    static let shared = TimeCalculationManager()

    func getNowDate() -> Date? {
        let string = dateFormatter.string(from: Date())
        return dateFormatter.date(from: string)
    }
    
    private let dateFormatter: DateFormatter = {
        $0.dateFormat = "a hh:mm"
        $0.timeZone = TimeZone(identifier: "Asia/Seoul")
        return $0
    }(DateFormatter())

    private let foreignFormatter: DateFormatter = {
        $0.dateFormat = "a hh:mm"
        $0.timeZone = .autoupdatingCurrent
        return $0
    }(DateFormatter())

    func testDummyDates() -> [MoTeDate] {
        return self.dummy
    }

    func todayBefore(_ day: Int) -> Date? {
        Calendar.current.date(byAdding: .day,
                              value: -day,
                              to: noon)
    }

    func todayWeekend() -> DateComponents {
        let vvv = Calendar.current.dateComponents([.weekday], from: Date())
        return vvv
    }
}

extension TimeCalculationManager {

    private var dummy: [MoTeDate] {
        [
            Calendar.current.date(byAdding: .day, value: -25, to: noon)!,
            Calendar.current.date(byAdding: .day, value: -20, to: noon)!,
            Calendar.current.date(byAdding: .day, value: -14, to: noon)!,
            Calendar.current.date(byAdding: .day, value: -12, to: noon)!,
            Calendar.current.date(byAdding: .day, value: -10, to: noon)!,
            Calendar.current.date(byAdding: .day, value: -8, to: noon)!,
            Calendar.current.date(byAdding: .day, value: -6, to: noon)!,
            Calendar.current.date(byAdding: .day, value: -4, to: noon)!,
            Calendar.current.date(byAdding: .day, value: -2, to: noon)!,
            Calendar.current.date(byAdding: .day, value: 0, to: noon)!
        ]
    }

    private var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
    }
}
