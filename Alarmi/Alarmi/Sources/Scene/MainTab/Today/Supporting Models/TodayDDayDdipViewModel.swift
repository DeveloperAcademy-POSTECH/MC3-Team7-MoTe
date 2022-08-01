//
//  File.swift
//  Alarmi
//
//  Created by Woody on 2022/08/01.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

struct TodayDDayDdipViewModel {
    var dday: Int = 0
    var isBefore: Bool = false
    init() {}

    init(_ model: CallDate?) {
        guard let model = model,
              let result = Date().fullDistance(from: model.date, resultIn: .day) else { return }

        self.dday = abs(result)
        self.isBefore = result >= 0 ? false : true
    }

    init(_ model: GoalTime) {
        guard
            let nextGoal = Calendar.current.date(byAdding: .day, value: model.period, to: model.startDate),
            let result = Date().fullDistance(from: nextGoal, resultIn: .day) else { return }

        self.dday = abs(result)
        self.isBefore = result >= 0 ? false : true
    }
}
