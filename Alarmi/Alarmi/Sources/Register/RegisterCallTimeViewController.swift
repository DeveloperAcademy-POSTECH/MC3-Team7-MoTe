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
    @IBOutlet weak var myLocationTimezoneSegmentedControl: UISegmentedControl!

    private lazy var button: AMButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.title = "다음"
        $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return $0
    }(AMButton())
    
    weak var delegate: RegisterCallTimeViewControllerDelegate?
    weak var tabDelegate: MainTabRegisterCallTimeViewControllerDelegate?
    
    var viewModel: RegisterViewModel?
    let current = Date()
    lazy var startTime: String = myFormatter.string(from: current)
    lazy var endTime: String = myFormatter.string(from: current)
    
    private let parentFormatter: DateFormatter = { formatter in
        formatter.dateFormat = "a hh:mm"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter
    }(DateFormatter())
    
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

    enum ButtonType {
        case next
        case edit

        var title: String {
            switch self {
            case .next:
                return "다음"
            case .edit:
                return "완료"
            }
        }
    }

    var type: ButtonType = .next {
        didSet {
            button.title = type.title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startTimeTransferredLabel.text = "한국은 \(parentFormatter.string(from: current))"
        endTimeTransferredLabel.text = "한국은 \(parentFormatter.string(from: current))"
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

    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "전화 시간"
    }

    private func configureBackground() {
        view.backgroundColor = .systemGroupedBackground

    @IBAction func startTimePickerAction(_ sender: UIDatePicker) {
        switch myLocationTimezoneSegmentedControl.selectedSegmentIndex {
        case 0:
            let myTimeString = myFormatter.string(from: sender.date)
            self.startTime = myTimeString
            
            let timeString = parentFormatter.string(from: sender.date)
            startTimeTransferredLabel.text = "한국은 \(timeString)"
        case 1:
            let myTimeString = myFormatter.string(from: sender.date)
            self.startTime = myTimeString
            startTimeTransferredLabel.text = "여기는 \(myTimeString)"
        default:
            break
        }
    }

    @IBAction func endTimePickerAction(_ sender: UIDatePicker) {
        switch myLocationTimezoneSegmentedControl.selectedSegmentIndex {
        case 0:
            let myTimeString = myFormatter.string(from: sender.date)
            self.endTime = myTimeString
            
            let timeString = parentFormatter.string(from: sender.date)
            endTimeTransferredLabel.text = "한국은 \(timeString)"
        case 1:
            let myTimeString = myFormatter.string(from: sender.date)
            self.endTime = myTimeString
            endTimeTransferredLabel.text = "여기는 \(myTimeString)"
        default:
            break
        }
    }
    
    @IBAction func myLocationTimezoneSegmentedControlAction(_ sender: UISegmentedControl) {
            switch sender.selectedSegmentIndex {
            case 0:
                startTimeTransferredLabel.text = "한국은 \(parentFormatter.string(from: current))"
                endTimeTransferredLabel.text = "한국은 \(parentFormatter.string(from: current))"
                startTimePicker.timeZone = TimeZone.autoupdatingCurrent
                endTimePicker.timeZone = TimeZone.autoupdatingCurrent
                
            case 1:
                startTimeTransferredLabel.text = "여기는 \(myFormatter.string(from: current))"
                endTimeTransferredLabel.text = "여기는 \(myFormatter.string(from: current))"
                startTimePicker.timeZone = TimeZone(identifier: "Asia/Seoul")
                endTimePicker.timeZone = TimeZone(identifier: "Asia/Seoul")
            default:
                break
            }
    }

    @objc private func buttonDidTap() {
        switch type {
        case .next:
            viewModel?.alarmData?.callTimeStart = startTime
            viewModel?.alarmData?.callTimeEnd = endTime
            delegate?.gotoRegisterPlanViewController()
        case .edit:
            tabDelegate?.gotoBack()
        }

    }
}
