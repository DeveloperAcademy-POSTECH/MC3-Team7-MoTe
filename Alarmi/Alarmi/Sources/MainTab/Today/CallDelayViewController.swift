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

    private let datePickerContainerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .secondarySystemGroupedBackground
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        return $0
    }(UIView())

    private lazy var datePicker: UIDatePicker = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.preferredDatePickerStyle = .inline
        $0.datePickerMode = .date
        $0.backgroundColor = .secondarySystemGroupedBackground
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
        view.addSubviews(descriptionLabel, datePickerContainerView)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            datePickerContainerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            datePickerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            datePickerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            datePickerContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 340)
        ])

        datePickerContainerView.addSubview(datePicker)

        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: datePickerContainerView.topAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: datePickerContainerView.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: datePickerContainerView.trailingAnchor, constant: -16),
            datePicker.bottomAnchor.constraint(equalTo: datePickerContainerView.bottomAnchor, constant: 0)
        ])
    }

    private func setup() {
        view.backgroundColor = .systemGroupedBackground
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