//
//  MainTabBarController.swift
//  Alarmi
//
//  Created by Woody on 2022/07/15.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {

    enum TabItem {
        case today
        case record

        var title: String {
            switch self {
            case .today:
                return "Today"
            case .record:
                return "History"
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

    private let todayViewController: UINavigationController!
    private let recordViewController: UINavigationController!

    init(todayNavigationController: UINavigationController,
         recordNavigationController: UINavigationController) {
        self.todayViewController = todayNavigationController
        self.recordViewController = recordNavigationController
        super.init(nibName: nil, bundle: nil)
        setup()
        attribute()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        todayViewController.tabBarItem = UITabBarItem(item: .today)
        recordViewController.tabBarItem = UITabBarItem(item: .record)
        viewControllers = [todayViewController, recordViewController]
    }

    private func attribute() {
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .systemGroupedBackground
    }
}
