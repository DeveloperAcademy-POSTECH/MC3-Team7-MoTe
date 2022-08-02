//
//  GoalTimeRepository.swift
//  Alarmi
//
//  Created by Woody on 2022/08/01.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

protocol GoalTimeRepository {
    var goalTime: CurrentValueSubject<GoalTime, Never> { get }
    func updateGoalTime(_ goalTime: GoalTime)
}

final class GoalTimeRepositoryImpl: GoalTimeRepository {

    private let goalTimeUserDefaults = GoalTimeUserDefaults(key: .goalTime)

    lazy var goalTime = CurrentValueSubject<GoalTime, Never>(value)

    func updateGoalTime(_ goalTime: GoalTime) {
        goalTimeUserDefaults.removeAll()
        goalTimeUserDefaults.save(goalTime)

        self.goalTime.send(goalTime)
    }

}

extension GoalTimeRepositoryImpl {
    var value: GoalTime {
        goalTimeUserDefaults.data ?? .init(startDate: Date(), period: 7)
    }
}
