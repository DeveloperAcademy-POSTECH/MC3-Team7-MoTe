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
    private var callPeriodRepository: CallPeriodRepository!
    private var callDateRepository: CallDateRepository!
    private var alarmRepostiory: AlarmRepository!
    private var callTimeRepository: CallTimeRepository!
    private var goalDateRepository: GoalDateRepository!

    lazy var isRegister: Bool = FirstUserDefaults(key: .firstUser).data ?? false

    init(
        navigationController: UINavigationController,
        callPeriodRepository: CallPeriodRepository,
        callDateRepository: CallDateRepository,
        alarmRepostiory: AlarmRepository,
        callTimeRepository: CallTimeRepository,
        goalDateRepository: GoalDateRepository
    ) {
        self.navigationController = navigationController
        self.callPeriodRepository = callPeriodRepository
        self.callDateRepository = callDateRepository
        self.alarmRepostiory = alarmRepostiory
        self.callTimeRepository = callTimeRepository
        self.goalDateRepository = goalDateRepository
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
            callPeriodRepository: callPeriodRepository,
            callDateRepository: callDateRepository,
            alarmRepostiory: alarmRepostiory,
            callTimeRepository: callTimeRepository,
            goalDateRepository: goalDateRepository
        )
        coordinator.delegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    private func showRegisterControllers() {
        let coordinator = RegisterCoordinator(
            navigationController: navigationController,
            callPeriodRepository: callPeriodRepository,
            callDateRepository: callDateRepository,
            alarmRepostiory: alarmRepostiory,
            callTimeRepository: callTimeRepository,
            goalDateRepository: goalDateRepository
        )
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
