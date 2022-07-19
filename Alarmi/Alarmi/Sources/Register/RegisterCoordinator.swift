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
                                 RegisterNotifyViewControllerDelegate,
                                 RegisterPlanViewControllerDelegate,
                                 RegisterCompleteViewControllerDelegate {

    var childCoordinators: [Coordinator] = []
    weak var delegate: ReigsterCoordinatorDelegate?

    private var navigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("☠️☠️☠️☠️☠️☠️☠️ \(String(describing: self)) ☠️☠️☠️☠️☠️☠️☠️")
    }

    func start() {
        let storyboard = UIStoryboard(name: "CallTime", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterCallTimeViewController") as? RegisterCallTimeViewController else {
            return
        }
        viewController.delegate = self
        self.navigationController.viewControllers = [viewController]
    }

    func nextButtonDidTap() {
        let storyboard = UIStoryboard(name: "SettingPlan", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterPlanViewController") as? RegisterPlanViewController else {
            return
        }
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func nextButton2DidTap() {
        let settingNotifyViewController = RegisterNotifyViewController()
        settingNotifyViewController.delegate = self
        navigationController?.pushViewController(settingNotifyViewController, animated: true)
    }

    func completButtonDidTap() {
        let settingCompletionViewController = RegisterCompleteViewController()
        settingCompletionViewController.delegate = self
        navigationController?.pushViewController(settingCompletionViewController, animated: true)
    }
    
    func startButtonDidTap() {
        delegate?.didRegister(self)
    }

}
