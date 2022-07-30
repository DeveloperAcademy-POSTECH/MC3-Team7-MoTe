//
//  CallTimeViewController.swift
//  Alarmi
//
//  Created by kwon ji won on 2022/07/18.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

protocol RegisterCallTimeViewControllerDelegate: AnyObject {
    func gotoRegisterPlanViewController()
}

protocol MainTabRegisterCallTimeViewControllerDelegate: AnyObject {
    func gotoBack()
}

class RegisterCallTimeViewController: UIViewController {
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var startTimeTransferredLabel: UILabel!
    @IBOutlet weak var endTimeTransferredLabel: UILabel!

//    @IBOutlet weak var myLocationTimezoneSegmentedControl: UISegmentedControl!

    weak var delegate: RegisterCallTimeViewControllerDelegate?
    weak var tabDelegate: MainTabRegisterCallTimeViewControllerDelegate?
    
    private let encoder = JSONEncoder()
    private var callTime = CallTime(start: Date(), end: Date())
    
    private let current = Date()
    private lazy var startTime: String = myFormatter.string(from: current)
    private lazy var endTime: String = myFormatter.string(from: current)
    
//    private let parentFormatter: DateFormatter = { formatter in
//        formatter.dateFormat = "a hh:mm"
//        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
//        return formatter
//    }(DateFormatter())
    
    private let myFormatter: DateFormatter = { formatter in
        formatter.dateFormat = "a hh:mm"
        formatter.timeZone = TimeZone.autoupdatingCurrent
        return formatter
    }(DateFormatter())
    
    private lazy var button: AMButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.title = "다음"
        $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return $0
    }(AMButton())

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
//        startTimeTransferredLabel.text = "한국은 \(parentFormatter.string(from: current))"
//        endTimeTransferredLabel.text = "한국은 \(parentFormatter.string(from: current))"
        attribute()
        layout()
    }
    
    private func attribute() {
        configureNavigationBar()
        configureBackground()
    }
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "전화 시간"
    }
    
    private func configureBackground() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    private func layout() {view.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @IBAction func startTimePickerAction(_ sender: UIDatePicker) {
        callTime.start = sender.date
        let myTimeString = myFormatter.string(from: sender.date)
        self.startTime = myTimeString
    }

    @IBAction func endTimePickerAction(_ sender: UIDatePicker) {
        let myTimeString = myFormatter.string(from: sender.date)
        self.endTime = myTimeString
        callTime.end = sender.date
    }
}

extension RegisterCallTimeViewController {

    @objc private func buttonDidTap() {
//        resetAllRecords(in: "CoreDataDate")
        saveCoreData(start: Date(), end: Date())
        updateMoteDate(day: Date(), keyName: "moteDate")
        
        switch type {
        case .register:
            delegate?.gotoRegisterPlanViewController()
        case .setting:
            tabDelegate?.gotoBack()
        }
        if let encoded = try? encoder.encode(callTime) {
            UserDefaults.standard.setValue(encoded, forKey: "CallTime")
        }
    }
}
