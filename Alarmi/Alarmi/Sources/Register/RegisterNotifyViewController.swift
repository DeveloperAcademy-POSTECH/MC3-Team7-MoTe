//
//  SettingNotifyViewController.swift
//  Alarmi
//
//  Created by Woody on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit
import UserNotifications

protocol RegisterNotifyViewControllerDelegate: AnyObject {
    func gotoRegisterCompleteViewController()
}

final class RegisterNotifyViewController: UIViewController {
    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "마지막으로 전화한지 7일이 되면 알림을 보내드려요."
        $0.setDynamicFont(.body)
        return $0
    }(UILabel())

    private lazy var alarmSetView: AlarmSetView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alarmSwitchChanged = { [weak self] isOn in
            self?.animateAlarmAgainSetView(isOn)
        }
        return $0
    }(AlarmSetView())

    private lazy var alarmAgainSetView: AlarmAgainSetView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(AlarmAgainSetView())

    private let alarmAgainSetDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "저희가 적절한 간격으로 알림을 다시 보내드려요."
        $0.textColor = .secondaryLabel
        $0.textAlignment = .right
        $0.setDynamicFont(.footnote)
        return $0
    }(UILabel())

    private lazy var button: AMButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.title = "완료"
        $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return $0
    }(AMButton())

    weak var delegate: RegisterNotifyViewControllerDelegate?

    private let notificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }

    private func attribute() {
        setup()
        setupNavigationBar()
        generateUserNotification()
    }

    private func layout() {
        view.addSubviews(descriptionLabel, alarmSetView, alarmAgainSetView, alarmAgainSetDescriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            alarmSetView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            alarmSetView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            alarmSetView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            alarmAgainSetView.topAnchor.constraint(equalTo: alarmSetView.bottomAnchor, constant: 16),
            alarmAgainSetView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            alarmAgainSetView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            alarmAgainSetDescriptionLabel.topAnchor.constraint(equalTo: alarmAgainSetView.bottomAnchor, constant: 8),
            alarmAgainSetDescriptionLabel.leadingAnchor.constraint(equalTo: alarmAgainSetView.leadingAnchor, constant: 16),
            alarmAgainSetDescriptionLabel.trailingAnchor.constraint(equalTo: alarmAgainSetView.trailingAnchor, constant: -16)
        ])

        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

    }

    private func setup() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    private func setupNavigationBar() {
        title = "알림"
    }

    private func animateAlarmAgainSetView(_ canBeEdit: Bool) {
        UIView.animate(withDuration: 0.33, delay: 0, options: .curveLinear, animations: {
            let opacity: Float = canBeEdit ? 1 : 0.4
            let isUserInteractionEnabled: Bool = canBeEdit
            
            self.alarmAgainSetView.layer.opacity = opacity
            self.alarmAgainSetDescriptionLabel.layer.opacity = opacity
            self.alarmAgainSetView.isUserInteractionEnabled = isUserInteractionEnabled
        }, completion: nil)
    }

    private func generateUserNotification() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if let error = error {
                print(error)
            } else {
                if granted {
                    // TODO: 상황에 따른 content 변화 필요
                    let content = UNMutableNotificationContent()
                    content.title = "아직 전화하지 않았어요"
                    content.subtitle = "아들아 보고싶다!!!"
                    content.body = "전화한지 3일이 지났어요 ㅠㅠ 🥹"
                    content.badge = 1
                    // TODO: startdate 목표시작일 받아와야 함
                    let startDate = Date()
                    let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: startDate)
                    // TODO: repeat -> 알림 반복횟수
                    // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                    let request = UNNotificationRequest(identifier: "identifier", content: content, trigger: trigger)
                    self.notificationCenter.add(request, withCompletionHandler: nil)
                } else {
                    print("Not Granted")
                }
            }
        }
    }

    @objc private func buttonDidTap() {
        delegate?.gotoRegisterCompleteViewController()
    }
}
