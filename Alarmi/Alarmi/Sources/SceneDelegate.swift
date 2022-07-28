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

        guard let midnight = calendar.date(
            bySettingHour: 0,
            minute: 0,
            second: 0,
            of: now
        ) else { return }

        guard let awakeTime = calendar.date(
            bySettingHour: 7,
            minute: 0,
            second: 0,
            of: now
        ) else { return }

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
    
    @objc func switchToDarkMode() {
        window?.overrideUserInterfaceStyle = .dark
    }
    
    @objc func switchToLightMode() {
        window?.overrideUserInterfaceStyle = .light
    }
}
