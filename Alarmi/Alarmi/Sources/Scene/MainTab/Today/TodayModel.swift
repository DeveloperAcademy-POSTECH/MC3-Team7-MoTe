//
//  TodayModel.swift
//  Alarmi
//
//  Created by Woody on 2022/08/01.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

struct TodayModel {
    private let callDateDataSource: CallDateRepository
    private let goalTimeDataSource: GoalTimeRepository
    private let callTimeDataSource: CallTimeRepository

    var callDateList: CurrentValueSubject<[CallDate], Never> {
        return callDateDataSource.callDateList
    }
    var goalTime: CurrentValueSubject<GoalTime, Never> {
        return goalTimeDataSource.goalTime
    }

    var callTime: CurrentValueSubject<CallTime, Never> {
        return callTimeDataSource.callTime
    }

    init(callDateSource: CallDateRepository = CallDateRepositoryImpl(),
         goalTimeDataSource: GoalTimeRepository = GoalTimeRepositoryImpl(),
         callTimeDataSource: CallTimeRepository = CallTimeRepositoryImpl()) {
        self.callDateDataSource = callDateSource
        self.goalTimeDataSource = goalTimeDataSource
        self.callTimeDataSource = callTimeDataSource
    }

    func updateGoalTime(_ goalTime: GoalTime) {
        return goalTimeDataSource.updateGoalTime(goalTime)
    }

    func addTodayDate(with isGoalSuccess: Bool) {
        callDateDataSource.addTodayDate(with: isGoalSuccess)
    }

    func removeTodayDate() {
        callDateDataSource.removeTodayDate()
    }
}
