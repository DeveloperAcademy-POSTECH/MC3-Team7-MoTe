//
//  RecordModel.swift
//  Alarmi
//
//  Created by Woody on 2022/07/27.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

struct RecordModel {
    private let callDateSource: CallDateRepository
    private let goalDataSource: GoalRepostiroy

    init(callDateSource: CallDateRepository = CallDateUserefaults(key: .callDate),
         goalDataSource: GoalRepostiroy = GoalUserefaults(key: .goal)) {
        self.callDateSource = callDateSource
        self.goalDataSource = goalDataSource
    }

    func fetchCallDateList() -> [CallDate] {
        return callDateSource.fetchCallDateList()
    }

    func fetchGoalList() -> [Goal] {
        return goalDataSource.fetchGoalList()
    }
}

protocol CallDateRepository {
    func fetchCallDateList() -> [CallDate]

}

protocol GoalRepostiroy {
    func fetchGoalList() -> [Goal]
}
