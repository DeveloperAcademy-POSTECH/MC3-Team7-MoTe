//
//  MainTabCoordinator.swift
//  Alarmi
//
//  Created by Woody on 2022/07/19.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class MainTabCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController!
    private var todayNavigationController: UINavigationController!
    private var recordNavgigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        navigationController.navigationBar.isHidden = true
        self.navigationController = navigationController
        self.todayNavigationController = UINavigationController()
        self.recordNavgigationController = UINavigationController()
    }

    func start() {
        let viewController = MainTabBarController(todayNavigationController: TodayViewController().wrappedByNavigationController(),
                                                  recordNavigationController: RecordViewController().wrappedByNavigationController())
        
        navigationController.viewControllers = [viewController]
    }
}
