//
//  GoalRepository.swift
//  Alarmi
//
//  Created by Woody on 2022/08/02.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

protocol GoalDateRepository {
    var goalDate: CurrentValueSubject<GoalDate, Never> { get }
    func updateGoalDate(_ date: GoalDate)
}

final class GoalDateRepositoryImpl: GoalDateRepository {
    private let goalDateUserDefaults = GoalDateUserDefaults(key: .goalDate)

    lazy var goalDate = CurrentValueSubject<GoalDate, Never>(value)

    func updateGoalDate(_ goalDate: GoalDate) {
        goalDateUserDefaults.removeAll()
        goalDateUserDefaults.save(goalDate)

        self.goalDate.send(goalDate)
    }

}

extension GoalDateRepositoryImpl {
    var value: GoalDate {
        goalDateUserDefaults.data ?? Date().addingTimeInterval(60 * 60 * 24 * 7)
    }
}
