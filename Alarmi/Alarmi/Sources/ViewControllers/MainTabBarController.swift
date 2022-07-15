//
//  MainTabBarController.swift
//  Alarmi
//
//  Created by Woody on 2022/07/15.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    private let todayViewController: UINavigationController = {
        let todayViewController = TodayViewController()
        todayViewController.view.backgroundColor = .systemGroupedBackground
        $0.tabBarItem = UITabBarItem(item: .today)
        $0.setViewControllers([todayViewController], animated: true)
        $0.navigationBar.prefersLargeTitles = true
        return $0
    }(UINavigationController())

    private let recordViewController: UINavigationController = {
        let recordViewController = RecordViewController()
        recordViewController.view.backgroundColor = .systemGroupedBackground
        $0.tabBarItem = UITabBarItem(item: .record)
        $0.setViewControllers([recordViewController], animated: true)
        $0.navigationBar.prefersLargeTitles = true
        return $0
    }(UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }

    private func attribute() {
        tabBar.isTranslucent = false
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .systemGroupedBackground
        viewControllers = [todayViewController, recordViewController]
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
