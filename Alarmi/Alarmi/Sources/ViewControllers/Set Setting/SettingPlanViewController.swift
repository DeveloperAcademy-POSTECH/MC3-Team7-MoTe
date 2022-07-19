//
//  SettingPlanViewController.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/18.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

class SettingPlanViewController: UIViewController {
    
    // TODO: 1하고 31 라벨 바꾸기.
    
    @IBOutlet var containerViews: [UIView]!
    @IBOutlet var settingDayLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!

    private lazy var button: AMButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.title = "다음"
        $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return $0
    }(AMButton())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    private func attribute() {
        containerViews.forEach {
            $0.layer.cornerRadius = 15
            $0.layer.masksToBounds = true
        }
    }

    private func layout() {

        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @IBAction func settingDaySlider(_ sender: UISlider) {
        let value = sender.value
        settingDayLabel.text = String(Int(value)) + "일에 한 번 전화할게요."
    }

    @objc private func buttonDidTap() {
        let settingNotifyViewController = SettingNotifyViewController()
        navigationController?.pushViewController(settingNotifyViewController, animated: true)
    }
}
