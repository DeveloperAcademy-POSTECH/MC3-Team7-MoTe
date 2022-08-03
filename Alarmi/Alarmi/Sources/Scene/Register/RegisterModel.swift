//
//  RegisterModel.swift
//  Alarmi
//
//  Created by Woody on 2022/08/02.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation
import Combine

struct RegisterModel {
    private let callDateDataSource: CallDateRepository
    private let callPeriodRepository: CallPeriodRepository
    private let callTimeDataSource: CallTimeRepository
    private let goalDateDataSource: GoalDateRepository
    private let alarmDataSource: AlarmRepository

    var callDateList: CurrentValueSubject<[CallDate], Never> {
        return callDateDataSource.callDateList
    }
    var callPeriod: CurrentValueSubject<CallPeriod, Never> {
        return callPeriodRepository.callPeriod
    }

    var callTime: CurrentValueSubject<CallTime, Never> {
        return callTimeDataSource.callTime
    }

    var goalDate: CurrentValueSubject<GoalDate, Never> {
        return goalDateDataSource.goalDate
    }

    init(callDateSource: CallDateRepository = CallDateRepositoryImpl(),
         callPeriodDataSource: CallPeriodRepository = CallPeriodRepositoryImpl(),
         callTimeDataSource: CallTimeRepository = CallTimeRepositoryImpl(),
         goalDateDataSource: GoalDateRepository = GoalDateRepositoryImpl(),
         alarmDataSource: AlarmRepository = AlarmRepositoryImpl()
    ) {
        self.callDateDataSource = callDateSource
        self.callPeriodRepository = callPeriodDataSource
        self.callTimeDataSource = callTimeDataSource
        self.goalDateDataSource = goalDateDataSource
        self.alarmDataSource = alarmDataSource
    }

    func updateCallPeriod(_ callPeriod: CallPeriod) {
        return callPeriodRepository.updateCallPeriod(callPeriod)
    }

    func updateGoalDate(_ date: GoalDate) {
        goalDateDataSource.updateGoalDate(date)
    }

    func updateAlarm(_ alarm: Alarm) {
        alarmDataSource.update(alarm: alarm)
    }

    func updateCallTime(_ callTime: CallTime) {
        callTimeDataSource.update(callTime: callTime)
    }
}
