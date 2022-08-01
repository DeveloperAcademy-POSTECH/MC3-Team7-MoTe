//
//  TodayModel.swift
//  Alarmi
//
//  Created by Woody on 2022/08/01.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

final class TodayModel {
    private let callDateDataSource: CallDateRepository
    private let goalTimeDataSource: GoalTimeRepository

    var callDateList: CurrentValueSubject<[CallDate], Never> {
        return callDateDataSource.callDateList
    }
    var goalTime: CurrentValueSubject<GoalTime, Never> {
        return goalTimeDataSource.goalTime
    }

    private var cancellable = Set<AnyCancellable>()

    init(callDateSource: CallDateRepository = CallDateRepositoryImpl(),
         goalTimeDataSource: GoalTimeRepository = GoalTimeRepositoryImpl(),
         callTimerDataSource: CallTimeRepository = CallTimeRepositoryImpl() ) {
        self.callDateDataSource = callDateSource
        self.goalTimeDataSource = goalTimeDataSource
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

    deinit {
        print("☠️☠️☠️☠️ \(String(describing: self)) ☠️☠️☠️☠️☠️")
    }
}
