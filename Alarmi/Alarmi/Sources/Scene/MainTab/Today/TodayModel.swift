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
    private let callPeriodRepository: CallPeriodRepository
    private let callTimeDataSource: CallTimeRepository
    private let goalDateDataSource: GoalDateRepository

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
         goalDateDataSource: GoalDateRepository = GoalDateRepositoryImpl()
    ) {
        self.callDateDataSource = callDateSource
        self.callPeriodRepository = callPeriodDataSource
        self.callTimeDataSource = callTimeDataSource
        self.goalDateDataSource = goalDateDataSource
    }

    func updateCallPeriod(_ callPeriod: CallPeriod) {
        return callPeriodRepository.updateCallPeriod(callPeriod)
    }

    func addTodayDate(with isGoalSuccess: Bool) {
        callDateDataSource.addTodayDate(with: isGoalSuccess)
    }

    func removeTodayDate() {
        callDateDataSource.removeTodayDate()
    }

    func updateGoalDate(_ date: GoalDate) {
        goalDateDataSource.updateGoalDate(date)
    }
}
