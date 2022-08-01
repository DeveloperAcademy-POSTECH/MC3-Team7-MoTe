//
//  TimerManager.swift
//  Alarmi
//
//  Created by Woody on 2022/07/31.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class TimerManager {
    static let shared = TimerManager()
    private init() {}

    let timer = Timer.publish(every: 1, tolerance: 0, on: .current, in: .default, options: nil)
}

/*
extension TimerManager {

    private func createClockTimer() -> Timer.TimerPublisher {
        return Timer.publish(
            every: 1,
            tolerance: nil,
            on: .current,
            in: .default,
            options: nil
        )
    }
}

extension TimerManager {

    private var window: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { fatalError() }
        return scene.windows.first
    }

    @objc private func switchToDarkMode() {
        DispatchQueue.main.async { [weak self] in
            self?.window?.overrideUserInterfaceStyle = .dark
        }

    }

    @objc private func switchToLightMode() {
        DispatchQueue.main.async { [weak self] in
            self?.window?.overrideUserInterfaceStyle = .light
        }
    }

}
*/
