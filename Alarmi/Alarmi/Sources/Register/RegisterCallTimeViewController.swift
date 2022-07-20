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
    func gotoRegisterPlanViewController(_ callTimeStart: String, _ callTimeEnd: String)
}

class RegisterCallTimeViewController: UIViewController {
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var startTimeTransferredLabel: UILabel!
    @IBOutlet weak var endTimeTransferredLabel: UILabel!
    @IBOutlet weak var myLocationTimezoneSegmentedControl: UISegmentedControl!

    weak var delegate: RegisterCallTimeViewControllerDelegate?

    var viewModel: RegisterViewwModel?
    
    let myTimeZone: TimeZone! = TimeZone(identifier: "America/Los_Angeles")
    let parentTimeZone: TimeZone! = TimeZone(identifier: "Asia/Seoul")
    
    lazy var startTime: String = "" {
        didSet {
            endTimeTransferredLabel.text = "한국은 \(startTime)"
        }
    }
    
    lazy var endTime: String = "" {
        didSet {
            endTimeTransferredLabel.text = "쿠퍼티노는 \(endTime)"
        }
    }
    
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
        configureNavigationBar()
        configureBackground()
    }

    private func layout() {

        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "전화 시간"
    }
    
    private func configureBackground() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    @IBAction func startTimePickerAction(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        
        switch myLocationTimezoneSegmentedControl.selectedSegmentIndex {
        case 0:
            startTimePicker.timeZone = myTimeZone
            dateFormatter.timeZone = parentTimeZone
            let timeString = dateFormatter.string(from: sender.date)
            startTimeTransferredLabel.text = "한국은 \(timeString)"
        case 1:
            startTimePicker.timeZone = parentTimeZone
            dateFormatter.timeZone = myTimeZone
            let timeString = dateFormatter.string(from: sender.date)
            startTimeTransferredLabel.text = "쿠퍼티노는 \(timeString)"
        default:
            break
        }
    }
    
    @IBAction func endTimePickerAction(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        
        switch myLocationTimezoneSegmentedControl.selectedSegmentIndex {
        case 0:
            endTimePicker.timeZone = myTimeZone
            dateFormatter.timeZone = parentTimeZone
            let timeString = dateFormatter.string(from: sender.date)
            startTime = timeString
        case 1:
            endTimePicker.timeZone = parentTimeZone
            dateFormatter.timeZone = myTimeZone
            let timeString = dateFormatter.string(from: sender.date)
            startTime = timeString
        default:
            break
        }
    }
    
    @IBAction func myLocationTimezoneSegmentedControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            startTimeTransferredLabel.text = "한국은"
            endTimeTransferredLabel.text = "한국은"
        case 1:
            startTimeTransferredLabel.text = "쿠퍼티노는"
            endTimeTransferredLabel.text = "쿠퍼티노는"
        default :
            break
        }
    }

    @objc private func buttonDidTap() {
        viewModel?.alarmData?.callTimeStart = startTime
        viewModel?.alarmData?.callTimeEnd = endTime
        delegate?.gotoRegisterPlanViewController()
    }
}
