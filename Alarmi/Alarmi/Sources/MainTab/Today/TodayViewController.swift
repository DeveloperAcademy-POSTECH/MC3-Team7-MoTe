//
//  TodayViewController.swift
//  Alarmi
//
//  Created by Woody on 2022/07/15.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

protocol TodayViewControllerDelegate: AnyObject {
    func gotoSettingViewController()
    func presentCallDelayViewController()
}

final class TodayViewController: UIViewController {

    // MARK: View
    
    private let clockStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .leading
        $0.spacing = -10
        return $0
    }(UIStackView())

    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "지금 한국은"
        $0.setDynamicFont(for: .body, weight: .semibold)
        return $0
    }(UILabel())

    private let statusDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "전화 가능 시간이 아니에요."
        $0.textAlignment = .right
        $0.setDynamicFont(for: .body, weight: .bold)
        return $0
    }(UILabel())

    private let realTimeClockLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.adjustsFontSizeToFitWidth = true
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 108, weight: .black)
        return $0
    }(UILabel())

    private let imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        // TODO: 시간에따라 사진바꿔줘야함
        $0.image = UIImage(named: "call")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

    private let dDayStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .leading
        $0.spacing = 32
        return $0
    }(UIStackView())

    private lazy var lastCallDDayView: TodayDdayView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(TodayDdayView())

    private lazy var fromPurposeDDayView: TodayDdayView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(TodayDdayView())

    weak var delegate: TodayViewControllerDelegate?

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setTimer()
    }

    // MARK: Method

    private func attribute() {
        view.backgroundColor = .systemGroupedBackground
        setupNavigationBar()
        lastCallDDayView.set(state: .init(buttonName: "전화했어요", descriptionLabelName: "마지막 전화", dDayLabel: "D+9"))
        fromPurposeDDayView.set(state: .init(buttonName: "미룰거예요", descriptionLabelName: "목표일로부터", dDayLabel: "D+2"))
    }

    private func layout() {
        view.addSubviews(clockStackView, imageView, dDayStackView)
        clockStackView.addArrangedSubviews(descriptionLabel, realTimeClockLabel, statusDescriptionLabel)
        dDayStackView.addArrangedSubviews(lastCallDDayView, fromPurposeDDayView)

        NSLayoutConstraint.activate([
            clockStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            clockStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            clockStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42)
        ])

        NSLayoutConstraint.activate([
            realTimeClockLabel.leadingAnchor.constraint(equalTo: clockStackView.leadingAnchor),
            realTimeClockLabel.trailingAnchor.constraint(equalTo: clockStackView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            statusDescriptionLabel.trailingAnchor.constraint(equalTo: clockStackView.trailingAnchor)
        ])

        // TODO: 이미지 크기 수정해야함. 이게맞음?
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
        ])

        NSLayoutConstraint.activate([
            dDayStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            dDayStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let image = UIImage(systemName: "gearshape")
        let barButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingButtonTapped))
        self.navigationItem.rightBarButtonItem = barButton
    }

    private func setTimer() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.currentTimeToKoreaTime(_:)), userInfo: nil, repeats: true)
    }
}

extension TodayViewController {

    // MARK: Button Action

    @objc private func settingButtonTapped() {
        delegate?.gotoSettingViewController()
    }

    @objc private func currentTimeToKoreaTime(_ sender: Timer) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "Asia/Seoul")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.dateFormat = "HH:mm"
        let currentLocationDate = Date()
        let koreaTime = dateFormatter.string(from: currentLocationDate)
        realTimeClockLabel.text = koreaTime
    }
}
