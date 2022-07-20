//
//  SettingPlanViewController.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/18.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

protocol RegisterPlanViewControllerDelegate: AnyObject {
    func gotoRegisterNotifyViewController()
    func gotoRegisterNotifyViewController(_ callTimePeriod: Int, _ callTimeStartDate: String)
}

class RegisterPlanViewController: UIViewController {
    
    @IBOutlet var containerViews: [UIView]!
    @IBOutlet var settingDayLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    lazy var callTimePeriod = 15 {
        didSet {
            settingDayLabel.text = String(callTimePeriod) + "일에 한 번 전화할게요."
        }
    }
    
    lazy var callTimeStartDate: String = calcDate()

    private lazy var button: AMButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.title = "다음"
        $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return $0
    }(AMButton())

    weak var delegate: RegisterPlanViewControllerDelegate?

    var viewModel: RegisterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    private func calcDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = dateFormatter.string(from: Date())
        return currentDateString
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
        callTimePeriod = Int(value)
    }
    
    @IBAction func settingStartDatePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let timeString = dateFormatter.string(from: sender.date)
        callTimeStartDate = timeString
    }
    
    @objc private func buttonDidTap() {
        viewModel?.alarmData?.startDate = callTimeStartDate
        viewModel?.alarmData?.callPeriod = callTimePeriod
        delegate?.gotoRegisterNotifyViewController()
    }
}
