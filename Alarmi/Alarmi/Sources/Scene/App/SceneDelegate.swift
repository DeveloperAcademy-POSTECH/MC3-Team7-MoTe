//
//  SceneDelegate.swift
//  Alarmi
//
//  Created by Woody on 2022/07/11.
//

import Combine
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
//
//    var goalTimeReppository: GoalTimeRepository
//    var callDateRepository: CallDateRepository
//    var alarmRepostiory: AlarmRepository
//    var callTimeRepository: CallTimeRepository

    private var cancellable = Set<AnyCancellable>()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = scene.windows.first ?? UIWindow(frame: UIScreen.main.bounds)

        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController

        coordinator = AppCoordinator(
            navigationController: navigationController,
            goalTimeRepository: GoalTimeRepositoryImpl(),
            callDateRepository: CallDateRepositoryImpl(),
            alarmRepostiory: AlarmRepositoryImpl(),
            callTimeRepository: CallTimeRepositoryImpl()
        )
        coordinator?.start()

        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = Date().judgeKoreaState().mode


        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            TimerManager.shared.timer
                .autoconnect()
                .filter { $0.judgeKoreaState() != .canCall }
                .map { $0.judgeKoreaState().mode }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    self?.window?.overrideUserInterfaceStyle = $0
                }.store(in: &self.cancellable)
            RunLoop.current.run()
        }

        // MARK: 테스트용
        CallDateUserefaults(key: .callDate).removeAll()
        CallDateUserefaults(key: .callDate).save([
//            CallDate(date: Date().before(day: 60), isGoalSuccess: true),
//            CallDate(date: Date().before(day: 39), isGoalSuccess: true),
//            CallDate(date: Date().before(day: 21), isGoalSuccess: true),
//            CallDate(date: Date().before(day: 10), isGoalSuccess: true),
//            CallDate(date: Date().before(day: 9), isGoalSuccess: true),
//            CallDate(date: Date().before(day: 8), isGoalSuccess: true),
//            CallDate(date: Date().before(day: 7), isGoalSuccess: true),
//            CallDate(date: Date().before(day: 6), isGoalSuccess: true),
//            CallDate(date: Date().before(day: 5), isGoalSuccess: true),
//            CallDate(date: Date().before(day: 4), isGoalSuccess: false),
//            CallDate(date: Date().before(day: 1), isGoalSuccess: false),
//            CallDate(date: Date().before(day: 0), isGoalSuccess: false)
        ])
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}
