//
//  CallDelayViewController.swift
//  Alarmi
//
//  Created by Woody on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

class CallDelayViewController: UIViewController {

    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "선택한 날짜에 알림이 오도록 이번 연락을 미룹니다."
        $0.setDynamicFont(.body)
        return $0
    }(UILabel())

    private lazy var datePicker: UIDatePicker = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.preferredDatePickerStyle = .inline
        $0.datePickerMode = .date
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.backgroundColor = .systemBackground
        $0.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return $0
    }(UIDatePicker())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }

    private func attribute() {
        setup()
        setupNavigationBar()
    }

    private func layout() {
        view.addSubviews(descriptionLabel, datePicker)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func setup() {
        view.backgroundColor = .secondarySystemBackground
    }

    private func setupNavigationBar() {
        title = "연락 미루기"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancelButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(doneButtonPressed))
    }

}

extension CallDelayViewController {

    @objc private func cancelButtonPressed() {
        dismiss(animated: true)
    }

    @objc private func doneButtonPressed() {
        // TODO: 알람 매니저를 통해 notification 재설정
        dismiss(animated: true)
    }

    @objc private func datePickerValueChanged() {
        // TODO: 선택된 값 저장
        print(datePicker.date)
    }
}
