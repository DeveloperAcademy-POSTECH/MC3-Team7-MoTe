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

    init(callDateSource: CallDateRepository = CallDateUserefaults(key: .callDate)) {
        self.callDateSource = callDateSource
    }

    func fetchCallDataList() -> [CallDate] {
        return callDateSource.fetchCallDateList()
    }
}

protocol CallDateRepository {
    func fetchCallDateList() -> [CallDate]
}
