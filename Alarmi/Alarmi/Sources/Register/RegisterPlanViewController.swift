//
//  SettingPlanViewController.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/18.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit
import CoreData

protocol RegisterPlanViewControllerDelegate: AnyObject {
    func gotoRegisterNotifyViewController()
}

protocol MainTabRegisterPlanViewControllerDelegate: AnyObject {
    func gotoBack()
}

final class RegisterPlanViewController: UIViewController {
    
    @IBOutlet private var startDatePicker: UIDatePicker!
    @IBOutlet private var containerViews: [UIView]!
    @IBOutlet private var settingDayLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var settingDayStepper: UIStepper!
    
    private lazy var callTimePeriod = 7 {
        didSet {
            settingDayLabel.text = String(callTimePeriod) + "일에 한 번"
        }
    }
    
    private let encoder = JSONEncoder()
    private var goal = Goal(startDate: Date(), period: 7)
    
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
        
        attribute()
        layout()
    }
    
    private func attribute() {
        containerViews.forEach {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        startDatePicker.minimumDate = Date()
        settingDayStepper.value = Double(callTimePeriod)
    }
    
    private func layout() {
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @IBAction private func settingDayStepper(_ sender: UIStepper) {
        let value = sender.value
        callTimePeriod = Int(value)
        goal.period = callTimePeriod
    }
    
    @IBAction private func settingStartDatePicker(_ sender: UIDatePicker) {
        goal.startDate = sender.date
    }
}

extension RegisterPlanViewController {
    @objc private func buttonDidTap() {
        
        planCoreDataSave(callTimePeriod: callTimePeriod, callDate: goal.startDate)
        
//        do {
//            let array: [NSManagedObject] = try readCoreData()!
//            print(array)
//        } catch {
//            print(error)
//        }
        switch type {
        case .register:
            delegate?.gotoRegisterNotifyViewController()
        case .setting:
            tabDelegate?.gotoBack()
        }
        if let encoded = try? encoder.encode(goal) {
            UserDefaults.standard.setValue(encoded, forKey: "Goal")
        }
    }
}
