//
//  MainTabCoordinator.swift
//  Alarmi
//
//  Created by Woody on 2022/07/19.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class MainTabCoordinator: Coordinator,
                                TodayViewControllerDelegate {

    var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController!
    private var todayNavigationController: UINavigationController!
    private var recordNavgigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        navigationController.navigationBar.isHidden = true
        self.navigationController = navigationController
        self.todayNavigationController = UINavigationController()
        self.recordNavgigationController = UINavigationController()
        todayNavigationController.navigationBar.prefersLargeTitles = true
        recordNavgigationController.navigationBar.prefersLargeTitles = true
    }

    func start() {
        setupTodayNavigationController()
        setupRecordNavgigationController()
        let viewController = MainTabBarController(todayNavigationController: todayNavigationController,
                                                  recordNavigationController: recordNavgigationController)
        navigationController.viewControllers = [viewController]
    }

    func gotoSettingViewController() {
        let settingViewController = SettingViewController()
        todayNavigationController.pushViewController(settingViewController, animated: true)
    }

    func presentCallDelayViewController() {
        let callDelayViewController = CallDelayViewController()
        let navigationController = callDelayViewController.wrappedByNavigationController()
        todayNavigationController.viewControllers[0].present(navigationController, animated: true)
    }
}

extension MainTabCoordinator {
    private func setupTodayNavigationController() {
        let todayViewController = TodayViewController()
        todayViewController.delegate = self
        todayNavigationController.viewControllers = [todayViewController]
    }

    private func setupRecordNavgigationController() {
        let recordViewController = RecordViewController()
        recordNavgigationController.viewControllers = [recordViewController]
    }
}
