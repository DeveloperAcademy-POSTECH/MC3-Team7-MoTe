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
    
    private var cancellable = Set<AnyCancellable>()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = scene.windows.first ?? UIWindow(frame: UIScreen.main.bounds)

        // MARK: 테스트용
//        CallDateUserefaults(key: .callDate).removeAll()
//        CallTimeUserDefaults(key: .callTime).removeAll()
//        CallPeriodUserDefaults(key: .callPeriod).removeAll()
//        GoalDateUserDefaults(key: .goalDate).removeAll()
//        AlarmUserefaults(key: .alarm).removeAll()

//        CallTimeUserDefaults(key: .callTime).save(.init(start: Date(), end: Date().addingTimeInterval(600)))
//        GoalDateUserDefaults(key: .goalDate).save(Date().after(day: 5))
//        CallPeriodUserDefaults(key: .callPeriod).save(7)
//        AlarmUserefaults(key: .alarm).save(.init(isAlarm: true, isAlarmAgain: true))
//        CallDateUserefaults(key: .callDate).save([
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
//            CallDate(date: Date().before(day: 1), isGoalSuccess: false)
//        ])











        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController

        coordinator = AppCoordinator(
            navigationController: navigationController,
            callPeriodRepository: CallPeriodRepositoryImpl(),
            callDateRepository: CallDateRepositoryImpl(),
            alarmRepostiory: AlarmRepositoryImpl(),
            callTimeRepository: CallTimeRepositoryImpl(),
            goalDateRepository: GoalDateRepositoryImpl()
        )
        coordinator?.start()

        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = Date().judgeKoreaState().mode
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            TimerManager.shared.timer
                .autoconnect()
                .map { $0.judgeKoreaState() }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    self?.window?.overrideUserInterfaceStyle = $0.mode
                }.store(in: &self.cancellable)
            RunLoop.current.run()
        }

    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}
