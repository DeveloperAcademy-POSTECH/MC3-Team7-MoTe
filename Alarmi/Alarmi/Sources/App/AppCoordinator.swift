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

    // MARK: UserDefaults 값에서 불어와야함
    var isRegister: Bool = true

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if self.isRegister {
            self.showMainTabController()
        } else {
            self.showRegisterControllers()
        }
    }

    private func showMainTabController() {
        let coordinator = MainTabCoordinator(navigationController: navigationController)
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
        showMainTabController()
    }

    func reset(_ coordinator: RegisterCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
        showRegisterControllers()
    }

}
