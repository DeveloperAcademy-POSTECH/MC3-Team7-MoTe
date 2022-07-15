//
//  MainTabBarController.swift
//  Alarmi
//
//  Created by Woody on 2022/07/15.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedByNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}
class MainTabBarController: UITabBarController {

    private let todayViewController: UINavigationController = {
        let todayViewController = TodayViewController()
        todayViewController.view.backgroundColor = .systemGroupedBackground
        return todayViewController.wrappedByNavigationController()
    }()

    private let recordViewController: UINavigationController = {
        let recordViewController = RecordViewController()
        recordViewController.view.backgroundColor = .systemGroupedBackground
        return recordViewController.wrappedByNavigationController()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        attribute()
    }

    private func setup() {
        todayViewController.tabBarItem = UITabBarItem(item: .today)
        recordViewController.tabBarItem = UITabBarItem(item: .record)
        viewControllers = [todayViewController, recordViewController]
    }

    private func attribute() {
        tabBar.isTranslucent = false
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .systemGroupedBackground
    }
}

extension MainTabBarController {

    enum TabItem {
        case today
        case record

        var title: String {
            switch self {
            case .today:
                return "오늘"
            case .record:
                return "기록"
            }
        }

        var imageName: String {
            switch self {
            case .today:
                return "doc.text.image"
            case .record:
                return "calendar"
            }
        }
    }

}
