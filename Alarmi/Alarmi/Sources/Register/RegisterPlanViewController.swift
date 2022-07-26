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
}

protocol MainTabRegisterPlanViewControllerDelegate: AnyObject {
    func gotoBack()
}

final class RegisterPlanViewController: UIViewController {
    
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet private var containerViews: [UIView]!
    @IBOutlet private var settingDayLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet var settingDayStepper: UIStepper!
    
    private lazy var callTimePeriod = 7 {
        didSet {
            settingDayLabel.text = String(callTimePeriod) + "일에 한 번 전화할게요."
        }
    }
    
    private lazy var callTimeStartDate: Date = calcDate()
    
    private var saveGoal = Goal(startDate: Date(), period: 7)

    private lazy var button: AMButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.title = "다음"
        $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return $0
    }(AMButton())

    weak var delegate: RegisterPlanViewControllerDelegate?
    weak var tabDelegate: MainTabRegisterPlanViewControllerDelegate?

    enum ButtonType: String {
        case register = "다음"
        case setting = "수정하기"
    }

    var type: ButtonType = .register {
        didSet {
            button.setTitle(type.rawValue, for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMinimumDate()
        settingDayStepper.value = 7
        attribute()
        layout()
    }
    
    private func setMinimumDate() {
        startDatePicker.minimumDate = Date()
    }
    
    private func calcDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = Date()
//        dateFormatter.date(from: dateFormatter.dateFormat)
//        let currentDateString = dateFormatter.string(from: Date())
        return currentDateString
    }
    
    private func attribute() {
        containerViews.forEach {
            $0.layer.cornerRadius = 10
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
    
    @IBAction func settingDayStepper(_ sender: UIStepper) {
        let value = sender.value
        callTimePeriod = Int(value)
        saveGoal.period = callTimePeriod
    }

    @IBAction private func settingStartDatePicker(_ sender: UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let timeString: Date = sender.date
        callTimeStartDate = timeString
        saveGoal.startDate = callTimeStartDate
    }
}

let encoder = JSONEncoder()

extension RegisterPlanViewController {
    @objc private func buttonDidTap() {
        switch type {
        case .register:
            delegate?.gotoRegisterNotifyViewController()
        case .setting:
            tabDelegate?.gotoBack()
        }
        if let encoded = try? encoder.encode(saveGoal) {
            UserDefaults.standard.setValue(encoded, forKey: "saveGoal")
        }
    }
}
