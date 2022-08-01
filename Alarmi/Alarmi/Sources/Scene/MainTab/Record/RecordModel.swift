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
    private let callDateDataSource: CallDateRepository

    var callDateList: CurrentValueSubject<[CallDate], Never> {
        return callDateDataSource.callDateList
    }
    
    init(callDateDataSource: CallDateRepository = CallDateRepositoryImpl()) {
        self.callDateDataSource = callDateDataSource
    }
}
