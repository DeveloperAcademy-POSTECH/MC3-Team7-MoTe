//
//  CallPeriodRepository.swift
//  Alarmi
//
//  Created by Woody on 2022/08/01.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

protocol CallPeriodRepository {
    var callPeriod: CurrentValueSubject<CallPeriod, Never> { get }
    func updateCallPeriod(_ callPeriod: CallPeriod)
}

final class CallPeriodRepositoryImpl: CallPeriodRepository {
    private let callPeriodUserDefaults = CallPeriodUserDefaults(key: .callPeriod)

    lazy var callPeriod = CurrentValueSubject<CallPeriod, Never>(value)

    func updateCallPeriod(_ callPeriod: CallPeriod) {
        callPeriodUserDefaults.removeAll()
        callPeriodUserDefaults.save(callPeriod)

        self.callPeriod.send(callPeriod)
    }

}

extension CallPeriodRepositoryImpl {
    var value: CallPeriod {
        callPeriodUserDefaults.data ?? 7
    }
}
