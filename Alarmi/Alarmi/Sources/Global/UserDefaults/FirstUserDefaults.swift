//
//  FirstUserDefaults.swift
//  Alarmi
//
//  Created by Woody on 2022/08/01.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation

struct FirstUserDefaults: UserDefaultsManager {
    typealias T = Bool

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
        UserDefaults.standard.set(data, forKey: key)
    }

    func removeAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
