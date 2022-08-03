//
//  GoalUserDefaults.swift
//  Alarmi
//
//  Created by Woody on 2022/07/28.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

struct CallPeriodUserDefaults: UserDefaultsManager {
    typealias T = CallPeriod

    private var key: String

    init(key: UserDefaultsKey) {
        self.key = key.rawValue
    }
    
    var data: T? {
        return UserDefaults.standard.integer(forKey: key)
    }

    var isEmpty: Bool {
        return data == nil
    }

    func save(_ data: T) {
        UserDefaults.standard.set(data, forKey: key)
    }

    func removeAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }

}
