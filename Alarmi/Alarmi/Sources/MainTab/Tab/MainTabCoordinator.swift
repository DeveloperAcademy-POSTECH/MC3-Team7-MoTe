//
//  MainTabCoordinator.swift
//  Alarmi
//
//  Created by Woody on 2022/07/19.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

protocol MainTabCoordinatorDelegate: AnyObject {
    func reset(_ coordinator: RegisterCoordinator)
}

final class MainTabCoordinator: Coordinator,
                                TodayViewControllerDelegate,
                                MainTabRegisterCallTimeViewControllerDelegate,
                                MainTabRegisterPlanViewControllerDelegate,
                                MainTabRegisterNotifyViewControllerDelegate {
    var childCoordinators: [Coordinator] = []
    weak var delegate: MainTabCoordinatorDelegate?

    private var tabBarController: MainTabBarController!
    private var navigationController: UINavigationController!
    private var todayNavigationController: UINavigationController!
    private var recordNavigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        navigationController.navigationBar.isHidden = true
        self.navigationController = navigationController
        self.todayNavigationController = UINavigationController()
        self.recordNavigationController = UINavigationController()
        todayNavigationController.navigationBar.prefersLargeTitles = true
        recordNavigationController.navigationBar.prefersLargeTitles = true
    }

    func start() {
        setupTodayNavigationController()
        setupRecordNavgigationController()
        let tabBarController = MainTabBarController(todayNavigationController: todayNavigationController,
                                                  recordNavigationController: recordNavigationController)
        navigationController.viewControllers = [tabBarController]
    }

    func gotoSettingViewController() {
        let settingViewController = SettingViewController()
        todayNavigationController.pushViewController(settingViewController, animated: true)
    }

    func presentCallDelayViewController() {
        let callDelayViewController = CallDelayViewController()
        let navigationController = callDelayViewController.wrappedByNavigationController()
        guard let today = todayNavigationController.viewControllers.first else { return }
        today.present(navigationController, animated: true)
    }

    func backtoTodayViewController() {
        todayNavigationController.popViewController(animated: true)
    }

    func gotoBack() {
        todayNavigationController.popViewController(animated: true)
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
        let viewModel = RecordViewModel(RecordModel())
        recordViewController.viewModel = viewModel
        recordNavigationController.viewControllers = [recordViewController]
    }
}
