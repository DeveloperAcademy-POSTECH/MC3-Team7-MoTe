//
//  RegisterCoordinator.swift/Users/woody/Apple Developer Academy/MC3-Team7-MoTe/Alarmi/Alarmi/Sources/ViewControllers
//  Alarmi
//
//  Created by Woody on 2022/07/19.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

protocol ReigsterCoordinatorDelegate: AnyObject {
    func didRegister(_ coordinator: RegisterCoordinator)
}

final class RegisterCoordinator: Coordinator,
                                 RegisterCallTimeViewControllerDelegate,
                                 RegisterPlanViewControllerDelegate,
                                 RegisterCompleteViewControllerDelegate {

    var childCoordinators: [Coordinator] = []
    weak var delegate: ReigsterCoordinatorDelegate?

    private var navigationController: UINavigationController!
    private var registerViewModel: RegisterViewModel!

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
        self.navigationController = navigationController
        self.callPeriodRepository = callPeriodRepository
        self.callDateRepository = callDateRepository
        self.alarmRepostiory = alarmRepostiory
        self.callTimeRepository = callTimeRepository
        self.goalDateRepository = goalDateRepository

        self.registerViewModel = RegisterViewModel(
            model: RegisterModel(
                callDateSource: callDateRepository,
                callPeriodDataSource: callPeriodRepository,
                callTimeDataSource: callTimeRepository,
                goalDateDataSource: goalDateRepository
            )
        )
    }

    func start() {
        let storyboard = UIStoryboard(name: "SettingPlan", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterPlanViewController") as? RegisterPlanViewController else {
            return
        }
        registerViewModel.registerPlanViewControllerDelegate = self
        viewController.viewModel = registerViewModel
        navigationController.viewControllers = [viewController]
    }
    
    func gotoRegisterCallTimeViewController() {
        let storyboard = UIStoryboard(name: "CallTime", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterCallTimeViewController") as? RegisterCallTimeViewController else {
            return
        }
        registerViewModel.registerCallTimeViewControllerDelegate = self
        viewController.viewModel = registerViewModel
        navigationController.pushViewController(viewController, animated: true)
    }

    func gotoRegisterCompleteViewController() {
        let viewController = RegisterCompleteViewController()
        registerViewModel.registerCompleteViewControllerDelegate = self
        viewController.viewModel = registerViewModel
        navigationController.pushViewController(viewController, animated: true)
    }

    func finishRegister() {
        delegate?.didRegister(self)
    }

}
