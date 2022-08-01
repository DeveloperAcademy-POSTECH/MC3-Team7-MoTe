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

    var goalTime = CurrentValueSubject<GoalTime, Never>(.init(startDate: Date(), period: 7))

    func updateGoalTime(_ goalTime: GoalTime) {
        print("레포지토리 업데이트", goalTime)
        
        goalTimeUserDefaults.removeAll()
        goalTimeUserDefaults.save(goalTime)

        self.goalTime.send(goalTime)
    }

}
