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
    var callTimer: CurrentValueSubject<CallTime, Never> { get }

    func update(callTime: CallTime)
}

final class CallTimeRepositoryImpl: CallTimeRepository {
    private let callTimeUserDefaults = CallTimeUserDefaults(key: .callDate)

    var callTimer: CurrentValueSubject<CallTime, Never> {
        .init(callTimeUserDefaults.data ?? dummyCallTime)
    }

    func update(callTime: CallTime) {
        callTimeUserDefaults.removeAll()
        callTimeUserDefaults.save(callTime)
    }

}

extension CallTimeRepositoryImpl {
    var dummyCallTime: CallTime {
        return .init(start: Date(), end: Date().addingTimeInterval(600))
    }
}
