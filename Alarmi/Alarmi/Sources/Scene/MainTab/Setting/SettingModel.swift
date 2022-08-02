//
//  SettingModel.swift
//  Alarmi
//
//  Created by Woody on 2022/08/01.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

struct SettingModel {
    private let goalTimeDataSource: GoalTimeRepository
    private let callTimeDataSource: CallTimeRepository
    private let alarmDataSource: AlarmRepository

    var goalTime: CurrentValueSubject<GoalTime, Never> {
        return goalTimeDataSource.goalTime
    }

    var callTime: CurrentValueSubject<CallTime, Never> {
        return callTimeDataSource.callTime
    }

    var alarm: CurrentValueSubject<Alarm, Never> {
        return alarmDataSource.alarm
    }

    init(goalTimeDataSource: GoalTimeRepository = GoalTimeRepositoryImpl(),
         callTimeDataSource: CallTimeRepository = CallTimeRepositoryImpl(),
         alarmDataSource: AlarmRepository = AlarmRepositoryImpl()) {
        self.goalTimeDataSource = goalTimeDataSource
        self.callTimeDataSource = callTimeDataSource
        self.alarmDataSource = alarmDataSource
    }

    func updateGoalTime(_ goalTime: GoalTime) {
        goalTimeDataSource.updateGoalTime(goalTime)
    }

    func updateCallTime(_ callTime: CallTime) {
        callTimeDataSource.update(callTime: callTime)
    }

    func updateAlarm(_ alarm: Alarm) {
        alarmDataSource.update(alarm: alarm)
    }
}
