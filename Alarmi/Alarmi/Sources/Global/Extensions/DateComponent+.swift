//
//  DateComponent+.swift
//  Alarmi
//
//  Created by Woody on 2022/07/31.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

extension DateComponents {
    static func koreaHour(_ hour: Int) -> Self {
        return .init(
            timeZone: TimeZone(identifier: "Asia/Seoul"),
            year: Calendar.current.component(.year, from: Date()),
            month: Calendar.current.component(.month, from: Date()),
            day: Calendar.current.component(.day, from: Date()),
            hour: hour
        )
    }
}
