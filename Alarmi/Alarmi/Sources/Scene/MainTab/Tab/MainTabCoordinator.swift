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
                                CallDelayViewControllerDelegate {
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
        tabBarController = MainTabBarController(todayNavigationController: todayNavigationController,
                                                  recordNavigationController: recordNavigationController)
        navigationController.viewControllers = [tabBarController]
    }

    func gotoSettingViewController() {
        let settingViewController = SettingViewController()
//        guard let today = todayNavigationController.viewControllers.first as? TodayViewController else { return }
//        settingViewController.viewModel = today.viewModel
        settingViewController.viewModel = SettingViewModel()
        todayNavigationController.pushViewController(settingViewController, animated: true)
    }

    func presentCallDelayViewController() {
        let callDelayViewController = CallDelayViewController()
        let navigationController = callDelayViewController.wrappedByNavigationController()
        guard let today = todayNavigationController.viewControllers.first as? TodayViewController else { return }
        callDelayViewController.viewModel = today.viewModel
        today.present(navigationController, animated: true)
    }

    func backtoTodayViewController() {
        todayNavigationController.popViewController(animated: true)
    }

    func gotoBack() {
        todayNavigationController.popViewController(animated: true)
    }

    func presentAlert(_ viewcontroller: CallDelayViewController) {
        viewcontroller.present(createWarningAlertController(), animated: true)
    }

    func dismiss(_ viewcontroller: CallDelayViewController) {
        viewcontroller.dismiss(animated: true)
    }
}

extension MainTabCoordinator {
    private func setupTodayNavigationController() {
        let todayViewController = TodayViewController()
        todayViewController.delegate = self
        todayViewController.viewModel = TodayViewModel(TodayModel())
        todayNavigationController.viewControllers = [todayViewController]
    }

    private func setupRecordNavgigationController() {
        let recordViewController = RecordViewController()
        let viewModel = RecordViewModel(RecordModel())
        recordViewController.viewModel = viewModel
        recordNavigationController.viewControllers = [recordViewController]
    }
}

extension MainTabCoordinator {
    private func createWarningAlertController() -> UIAlertController {
        let alertController = UIAlertController(
            title: "경고문",
            message: "🔥 당신은 불효자이신가요? 🔥\n당신은 자식의 자격이 없습니다.\n당장 전화드리세요.",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "알겠어용", style: .default)
        alertController.addAction(action)

        return alertController
    }
}
