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

    func addTimerForBackgroundChange() {
        DispatchQueue.global().async { [weak self] in
            guard let darkModeTimer = self?.createAwakeTimerTimer() else { fatalError() }
            guard let lightModeTimer = self?.createMidNightTimeTimer() else { fatalError() }

            RunLoop.current.add(darkModeTimer, forMode: .default)
            RunLoop.current.add(lightModeTimer, forMode: .default)
            RunLoop.current.run()
        }
    }

}

extension TimerManager {

    private func createMidNightTimeTimer() -> Timer {
        return Timer(
            fireAt: KoreaTimeManager.shared.getTodayMidNightTime(),
            interval: 0,
            target: Self.shared,
            selector: #selector(switchToDarkMode),
            userInfo: nil,
            repeats: false
        )
    }

    private func createAwakeTimerTimer() -> Timer {
        return Timer(
            fireAt: KoreaTimeManager.shared.getTodayAwakeTime(),
            interval: 0,
            target: Self.shared,
            selector: #selector(switchToLightMode),
            userInfo: nil,
            repeats: false
        )
    }

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
