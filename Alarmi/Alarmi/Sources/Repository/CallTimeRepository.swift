//
//  CallTimeRepository.swift
//  Alarmi
//
//  Created by Woody on 2022/08/01.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Combine
import Foundation

protocol CallTimeRepository {
    var callTime: CurrentValueSubject<CallTime, Never> { get }

    func update(callTime: CallTime)
}

final class CallTimeRepositoryImpl: CallTimeRepository {
    private let callTimeUserDefaults = CallTimeUserDefaults(key: .callTime)

    lazy var callTime = CurrentValueSubject<CallTime, Never>(value)

    func update(callTime: CallTime) {
        callTimeUserDefaults.removeAll()
        callTimeUserDefaults.save(callTime)
        self.callTime.send(callTime)
    }

}

extension CallTimeRepositoryImpl {
    var value: CallTime {
        callTimeUserDefaults.data ?? .init(start: Date(), end: Date().addingTimeInterval(600))
    }
}
