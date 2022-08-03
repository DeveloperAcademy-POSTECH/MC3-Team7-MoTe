//
//  GoalUserDefaults.swift
//  Alarmi
//
//  Created by Woody on 2022/08/02.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

struct GoalDateUserDefaults: UserDefaultsManager {
    typealias T = GoalDate

    private var key: String

    init(key: UserDefaultsKey) {
        self.key = key.rawValue
    }

    var data: T? {
        return UserDefaults.standard.getCodable(for: key)
    }

    var isEmpty: Bool {
        return data == nil
    }

    func save(_ data: T) {
        UserDefaults.standard.storeCodable(data, key: key)
    }

    func removeAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
