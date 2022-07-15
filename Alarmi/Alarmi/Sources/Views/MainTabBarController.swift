//
//  MainTabBarController.swift
//  Alarmi
//
//  Created by Woody on 2022/07/15.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    private let todayViewController: TodayViewController = {
        $0.view.backgroundColor = .systemGroupedBackground
        $0.tabBarItem = UITabBarItem(title: "오늘", imageName: "doc.text.image")
        return $0
    }(TodayViewController())

    private let dummyViewController: DummyViewController = {
        $0.view.backgroundColor = .brown
        $0.tabBarItem = UITabBarItem(title: "기록", imageName: "calendar")
        return $0
    }(DummyViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }

    private func attribute() {
        tabBar.isTranslucent = false
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .systemGroupedBackground
        viewControllers = [todayViewController, dummyViewController]
    }
}
