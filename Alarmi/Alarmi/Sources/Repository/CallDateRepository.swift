//
//  CallDateRepository.swift
//  Alarmi
//
//  Created by Woody on 2022/08/01.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

protocol CallDateRepository {
    var callDateList: CurrentValueSubject<[CallDate], Never> { get }

    func addTodayDate(with isGoalSuccess: Bool)
    func removeTodayDate()
}

final class CallDateRepositoryImpl: CallDateRepository {
    private let callDateUserDefaults = CallDateUserefaults(key: .callDate)
    
    lazy var callDateList = CurrentValueSubject<[CallDate], Never>(value)

    func addTodayDate(with isGoalSuccess: Bool) {
        var newList = callDateUserDefaults.data ?? []
        newList.append(CallDate(date: Date(), isGoalSuccess: isGoalSuccess))
        callDateUserDefaults.removeAll()
        callDateUserDefaults.save(newList)
        callDateList.send(value)
    }

    func removeTodayDate() {
        var newList = callDateUserDefaults.data ?? []
        newList.remove(at: newList.count - 1)
        callDateUserDefaults.removeAll()
        callDateUserDefaults.save(newList)
        callDateList.send(newList)
    }
}

extension CallDateRepositoryImpl {
    var value: [CallDate] {
        return callDateUserDefaults.data ?? []
    }
}
