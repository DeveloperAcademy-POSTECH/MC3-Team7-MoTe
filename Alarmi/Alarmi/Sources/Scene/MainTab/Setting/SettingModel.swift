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
    private let callPeriodDataSource: CallPeriodRepository
    private let callTimeDataSource: CallTimeRepository
    private let alarmDataSource: AlarmRepository
    private let goalDateDataSource: GoalDateRepository

    var callPeriod: CurrentValueSubject<CallPeriod, Never> {
        return callPeriodDataSource.callPeriod
    }

    var callTime: CurrentValueSubject<CallTime, Never> {
        return callTimeDataSource.callTime
    }

    var alarm: CurrentValueSubject<Alarm, Never> {
        return alarmDataSource.alarm
    }

    var goalDate: CurrentValueSubject<GoalDate, Never> {
        return goalDateDataSource.goalDate
    }

    init(callPeriodDataSource: CallPeriodRepository = CallPeriodRepositoryImpl(),
         callTimeDataSource: CallTimeRepository = CallTimeRepositoryImpl(),
         alarmDataSource: AlarmRepository = AlarmRepositoryImpl(),
         goalDateDataSource: GoalDateRepository = GoalDateRepositoryImpl()) {
        self.callPeriodDataSource = callPeriodDataSource
        self.callTimeDataSource = callTimeDataSource
        self.alarmDataSource = alarmDataSource
        self.goalDateDataSource = goalDateDataSource
    }

    func updateCallPeriod(_ callPeriod: CallPeriod) {
        callPeriodDataSource.updateCallPeriod(callPeriod)
    }

    func updateCallTime(_ callTime: CallTime) {
        callTimeDataSource.update(callTime: callTime)
    }

    func updateAlarm(_ alarm: Alarm) {
        alarmDataSource.update(alarm: alarm)
    }
}
