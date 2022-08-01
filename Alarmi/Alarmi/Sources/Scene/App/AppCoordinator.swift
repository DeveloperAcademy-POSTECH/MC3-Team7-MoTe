//
//  AppCoordinator.swift
//  Alarmi
//
//  Created by Woody on 2022/07/19.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator,
                      ReigsterCoordinatorDelegate,
                      MainTabCoordinatorDelegate {
    var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController!
    private var goalTimeReppository: GoalTimeRepository!
    private var callDateRepository: CallDateRepository!
    private var alarmRepostiory: AlarmRepository!
    private var callTimeRepository: CallTimeRepository!

    lazy var isRegister: Bool = FirstUserDefaults(key: .firstUser).data ?? false

    init(
        navigationController: UINavigationController,
        goalTimeRepository: GoalTimeRepository,
        callDateRepository: CallDateRepository,
        alarmRepostiory: AlarmRepository,
        callTimeRepository: CallTimeRepository
    ) {
        self.navigationController = navigationController
        self.goalTimeReppository = goalTimeRepository
        self.callDateRepository = callDateRepository
        self.alarmRepostiory = alarmRepostiory
        self.callTimeRepository = callTimeRepository
    }
    
    func start() {
        if self.isRegister {
            self.showMainTabController()
        } else {
            self.showRegisterControllers()
        }
    }

    private func showMainTabController() {
        let coordinator = MainTabCoordinator(
            navigationController: navigationController,
            goalTimeRepository: goalTimeReppository,
            callDateRepository: callDateRepository,
            alarmRepostiory: alarmRepostiory,
            callTimeRepository: callTimeRepository
        )
        coordinator.delegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    private func showRegisterControllers() {
        let coordinator = RegisterCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    func didRegister(_ coordinator: RegisterCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }

        FirstUserDefaults(key: .firstUser).save(true)
        showMainTabController()
    }

    func reset(_ coordinator: RegisterCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
        showRegisterControllers()
    }

}
