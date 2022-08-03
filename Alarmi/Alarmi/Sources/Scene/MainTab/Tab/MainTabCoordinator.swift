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
                                RecordViewControllerDelegate,
                                CallDelayViewControllerDelegate {
    var childCoordinators: [Coordinator] = []
    weak var delegate: MainTabCoordinatorDelegate?

    private var tabBarController: MainTabBarController!
    private var navigationController: UINavigationController!
    private var todayNavigationController: UINavigationController!
    private var recordNavigationController: UINavigationController!

    private var callPeriodRepository: CallPeriodRepository!
    private var callDateRepository: CallDateRepository!
    private var alarmRepostiory: AlarmRepository!
    private var callTimeRepository: CallTimeRepository!
    private var goalDateRepository: GoalDateRepository!

    init(
        navigationController: UINavigationController,
        callPeriodRepository: CallPeriodRepository,
        callDateRepository: CallDateRepository,
        alarmRepostiory: AlarmRepository,
        callTimeRepository: CallTimeRepository,
        goalDateRepository: GoalDateRepository
    ) {
        navigationController.navigationBar.isHidden = true
        self.navigationController = navigationController
        self.todayNavigationController = UINavigationController()
        self.recordNavigationController = UINavigationController()
        todayNavigationController.navigationBar.prefersLargeTitles = true
        recordNavigationController.navigationBar.prefersLargeTitles = true

        self.navigationController = navigationController
        self.callPeriodRepository = callPeriodRepository
        self.callDateRepository = callDateRepository
        self.alarmRepostiory = alarmRepostiory
        self.callTimeRepository = callTimeRepository
        self.goalDateRepository = goalDateRepository
    }

    func start() {
        setupTodayNavigationController()
        setupRecordNavgigationController()
        tabBarController = MainTabBarController(todayNavigationController: todayNavigationController,
                                                  recordNavigationController: recordNavigationController)
        navigationController.setViewControllers([tabBarController], animated: true)
    }

    func gotoSettingViewControllerFromTodayView() {
        let settingViewController = SettingViewController()
        settingViewController.viewModel = SettingViewModel(
            SettingModel(
                callPeriodDataSource: callPeriodRepository,
                callTimeDataSource: callTimeRepository,
                alarmDataSource: alarmRepostiory
            )
        )
        todayNavigationController.pushViewController(settingViewController, animated: true)
    }
    
    func gotoSettingViewControllerFromRecordView() {
        let settingViewController = SettingViewController()
        settingViewController.viewModel = SettingViewModel(
            SettingModel(
                callPeriodDataSource: callPeriodRepository,
                callTimeDataSource: callTimeRepository,
                alarmDataSource: alarmRepostiory
            )
        )
        recordNavigationController.pushViewController(settingViewController, animated: true)
    }

    func presentCallDelayViewController() {
        let callDelayViewController = CallDelayViewController()
        let navigationController = callDelayViewController.wrappedByNavigationController()
        guard let today = todayNavigationController.viewControllers.first as? TodayViewController else { return }
        callDelayViewController.delegate = self
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
        todayViewController.viewModel = TodayViewModel(
            TodayModel(
                callDateSource: callDateRepository,
                callPeriodDataSource: callPeriodRepository,
                callTimeDataSource: callTimeRepository,
                goalDateDataSource: goalDateRepository
            )
        )
        todayNavigationController.viewControllers = [todayViewController]
    }

    private func setupRecordNavgigationController() {
        let recordViewController = RecordViewController()
        recordViewController.delegate = self
        let viewModel = RecordViewModel(
            RecordModel(
                callDateDataSource: callDateRepository
            )
        )
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

    private enum WarningAlert {
        case notAllow
        case completeWarning

        var title: String {
            switch self {
            case .notAllow:
                return "못 미뤄요 경고문"
            case .completeWarning:
                return "정말 미루실 거예요...?"
            }
        }
        var message: String {
            switch self {
            case .notAllow:
                return "🔥 당신은 불효자이신가요? 🔥\n당신은 자식의 자격이 없습니다.\n당장 전화드리세요."
            case .completeWarning:
                return "알림을 이 날로 미루게 돼요. "
            }
        }
    }
}
