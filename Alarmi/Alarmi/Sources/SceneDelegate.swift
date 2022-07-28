//
//  SceneDelegate.swift
//  Alarmi
//
//  Created by Woody on 2022/07/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = scene.windows.first ?? UIWindow(frame: UIScreen.main.bounds)

        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController

        coordinator = AppCoordinator(navigationController: navigationController)
        coordinator?.start()

        window?.makeKeyAndVisible()
        
        setLightOrDarkMode()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}

private extension SceneDelegate {

    func setLightOrDarkMode() {
        let calendar = Calendar.current
        let now = Date()
        
        let deviceMidnightHour = getConvertedHour(koreaHour: 0)
        let deviceAwakeHour = getConvertedHour(koreaHour: 7)
        
        let midnight = calendar.date(
            bySettingHour: deviceMidnightHour,
            minute: 0,
            second: 0,
            of: now
        )!

        let awakeTime = calendar.date(
            bySettingHour: deviceAwakeHour,
            minute: 0,
            second: 0,
            of: now
        )!

        let midnightCheckingTimer = Timer(
            fireAt: midnight,
            interval: 0,
            target: self,
            selector: #selector(switchToDarkMode),
            userInfo: nil,
            repeats: false
        )
        
        let awakeTimeCheckingTimer = Timer(
            fireAt: awakeTime,
            interval: 0,
            target: self,
            selector: #selector(switchToLightMode),
            userInfo: nil,
            repeats: false
        )

        RunLoop.main.add(midnightCheckingTimer, forMode: .common)
        RunLoop.main.add(awakeTimeCheckingTimer, forMode: .common)
    }
    
    func getConvertedHour(koreaHour hour: Int) -> Int {
        let calendar = Calendar.current
        let now = Date()
        let currentYear = calendar.component(.year, from: now)
        let currentMonth = calendar.component(.month, from: now)
        let currentDay = calendar.component(.day, from: now)

        let myTimeFormatter: DateFormatter = { formatter in
            formatter.timeZone = TimeZone.autoupdatingCurrent
            formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            return formatter
        }(DateFormatter())

        let koreaTimeZone = TimeZone(identifier: "Asia/Seoul")
        let koreaMidnightComponents = DateComponents(
            timeZone: koreaTimeZone,
            year: currentYear,
            month: currentMonth,
            day: currentDay,
            hour: hour,
            minute: 0,
            second: 0
        )
        let koreaMidnightDate = calendar.date(from: koreaMidnightComponents)!
        let convertedDateString = myTimeFormatter.string(from: koreaMidnightDate)
        let convertedDate = myTimeFormatter.date(from: convertedDateString)!
        return calendar.component(.hour, from: convertedDate)
    }
    
    @objc func switchToDarkMode() {
        window?.overrideUserInterfaceStyle = .dark
    }
    
    @objc func switchToLightMode() {
        window?.overrideUserInterfaceStyle = .light
    }
}
