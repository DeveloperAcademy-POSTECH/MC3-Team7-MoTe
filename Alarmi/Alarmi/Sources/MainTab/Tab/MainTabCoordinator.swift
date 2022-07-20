//
//  MainTabCoordinator.swift
//  Alarmi
//
//  Created by Woody on 2022/07/19.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class MainTabCoordinator: Coordinator,
                                SettingViewControllerDelegate,
                                TodayViewControllerDelegate,
                                MainTabRegisterCallTimeViewControllerDelegate,
                                MainTabRegisterPlanViewControllerDelegate,
                                MainTabRegisterNotifyViewControllerDelegate {

    var childCoordinators: [Coordinator] = []
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
        let viewController = MainTabBarController(todayNavigationController: todayNavigationController,
                                                  recordNavigationController: recordNavigationController)
        navigationController.viewControllers = [viewController]
    }

    func gotoSettingViewController() {
        let settingViewController = SettingViewController()
        settingViewController.delegate = self
        todayNavigationController.pushViewController(settingViewController, animated: true)
    }

    func presentCallDelayViewController() {
        let callDelayViewController = CallDelayViewController()
        let navigationController = callDelayViewController.wrappedByNavigationController()
        guard let today = todayNavigationController.viewControllers.first else { return }
        today.present(navigationController, animated: true)
    }

    func gotoRegisterCallTimeViewController() {
        let storyboard = UIStoryboard(name: "CallTime", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterCallTimeViewController") as? RegisterCallTimeViewController else {
            return
        }
        viewController.type = .edit
        viewController.tabDelegate = self
        todayNavigationController.pushViewController(viewController, animated: true)
    }

    func gotoRegisterPlanViewController() {
        let storyboard = UIStoryboard(name: "SettingPlan", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterPlanViewController") as? RegisterPlanViewController else {
            return
        }
        viewController.type = .edit
        viewController.tabDelegate = self
        todayNavigationController.pushViewController(viewController, animated: true)
    }

    func gotoRegisterNotifyViewController() {
        let viewController = RegisterNotifyViewController()
        viewController.type = .edit
        viewController.tabDelegate = self
        todayNavigationController?.pushViewController(viewController, animated: true)
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
        recordNavigationController.viewControllers = [recordViewController]
    }
}
