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

    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "지금 한국은"
        $0.textAlignment = .left
        $0.setDynamicFont(for: .body, weight: .semibold)
        return $0
    }(UILabel())

    private lazy var koreaTimeLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.text = Formatter.HHMMKoreaDateFormatter.string(from: Date())
        $0.setDynamicFont(for: .largeTitle, weight: .black)
        $0.font = .systemFont(ofSize: 108, weight: .black)
        return $0
    }(UILabel())

    private let statusDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .right
        $0.setDynamicFont(for: .body, weight: .semibold)
        return $0
    }(UILabel())

    private let pandaImageBoardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let pandaImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

    private let dDayStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        return $0
    }(UIStackView())

    private lazy var lastCallDDayView: TodayDdayView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        return $0
    }(TodayDdayView(type: .lastCall))

    private lazy var nextGoalDDayView: TodayDdayView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        return $0
    }(TodayDdayView(type: .nextGoal))

    weak var delegate: TodayViewControllerDelegate?

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        attribute()
        layout()
        setTimer()
        changeImage()
    }

    // MARK: Method

    private func attribute() {
        view.backgroundColor = .systemGroupedBackground
    }

    private func calculateDDay() {
        // startDate에 커밋 내역 저장
    }

    private func layout() {
        view.addSubviews(descriptionLabel, koreaTimeLabel, statusDescriptionLabel)
        view.addSubviews(pandaImageBoardView, dDayStackView)

        pandaImageBoardView.addSubview(pandaImageView)

        dDayStackView.addArrangedSubviews(lastCallDDayView, nextGoalDDayView)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            descriptionLabel.leadingAnchor.constraint(equalTo: koreaTimeLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: koreaTimeLabel.trailingAnchor),

            koreaTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            koreaTimeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),

            statusDescriptionLabel.topAnchor.constraint(equalTo: koreaTimeLabel.bottomAnchor),
            statusDescriptionLabel.leadingAnchor.constraint(equalTo: koreaTimeLabel.leadingAnchor),
            statusDescriptionLabel.trailingAnchor.constraint(equalTo: koreaTimeLabel.trailingAnchor),

            pandaImageBoardView.topAnchor.constraint(equalTo: statusDescriptionLabel.bottomAnchor),
            pandaImageBoardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pandaImageBoardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            pandaImageView.centerXAnchor.constraint(equalTo: pandaImageBoardView.centerXAnchor),
            pandaImageView.centerYAnchor.constraint(equalTo: pandaImageBoardView.centerYAnchor),
            pandaImageView.leadingAnchor.constraint(equalTo: pandaImageBoardView.leadingAnchor, constant: 80),
            pandaImageView.trailingAnchor.constraint(equalTo: pandaImageBoardView.trailingAnchor, constant: -80),

            dDayStackView.topAnchor.constraint(equalTo: pandaImageBoardView.bottomAnchor),
            dDayStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            dDayStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            dDayStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            dDayStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let image = UIImage(systemName: "gearshape")
        let barButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingButtonTapped))
        self.navigationItem.rightBarButtonItem = barButton
        navigationItem.largeTitleDisplayMode = .never
    }

    private func changeImage() {
        let calendar = Calendar.current
        let now = Date()

        let sleepingHour = getConvertedHour(koreaHour: 0)
        let workingHour = getConvertedHour(koreaHour: 7)
        let waitingHour = getConvertedHour(koreaHour: 18)

        // 프로퍼티
        let sleeping = calendar.date(
            bySettingHour: sleepingHour,
            minute: 0,
            second: 0,
            of: now
        )!

        let working = calendar.date(
            bySettingHour: workingHour,
            minute: 0,
            second: 0,
            of: now
        )!

        let waiting = calendar.date(
            bySettingHour: waitingHour,
            minute: 0,
            second: 0,
            of: now
        )!

        // 타이머 돌림
        let sleepingCheckTimer = Timer(
            fireAt: sleeping,
            interval: 0,
            target: self,
            selector: #selector(switchToSleepingImage),
            userInfo: nil,
            repeats: false
        )

        let workingCheckTimer = Timer(
            fireAt: working,
            interval: 0,
            target: self,
            selector: #selector(switchToWorkingImage),
            userInfo: nil,
            repeats: false
        )

        let waitingCheckTimer = Timer(
            fireAt: waiting,
            interval: 0,
            target: self,
            selector: #selector(switchToWaitingImage),
            userInfo: nil,
            repeats: false
        )

        RunLoop.main.add(sleepingCheckTimer, forMode: .common)
        RunLoop.main.add(workingCheckTimer, forMode: .common)
        RunLoop.main.add(waitingCheckTimer, forMode: .common)
    }

    // TODO: 아보꺼머지되면 아보꺼를 재사용하도록 리팩토링
    private func getConvertedHour(koreaHour hour: Int) -> Int {
        let calendar = Calendar.current
        let now = Date()
        let currentYear = calendar.component(.year, from: now)
        let currentMonth = calendar.component(.month, from: now)
        let currentDay = calendar.component(.day, from: now)

        let myTimeFormatter: DateFormatter = { formatter in
            formatter.timeZone = TimeZone.autoupdatingCurrent
            formatter.dateFormat = "HH"
            return formatter
        }(DateFormatter())

        let koreaTimeZone = TimeZone(identifier: "Asia/Seoul")
        let koreaMidnightComponents = DateComponents(
            timeZone: koreaTimeZone,
            year: currentYear,
            month: currentMonth,
            day: currentDay,
            hour: hour,
            minute: 0,
            second: 0
        )
        let koreaMidnightDate = calendar.date(from: koreaMidnightComponents)!
        let convertedDateString = myTimeFormatter.string(from: koreaMidnightDate)
        let convertedHourInt = Int(convertedDateString)!
        return convertedHourInt
    }

    private func setTimer() {
//        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.currentTimeToKoreaTime(_:)), userInfo: nil, repeats: true)
    }
}

extension TodayViewController {

    // MARK: Button Action

    @objc private func settingButtonTapped() {
        delegate?.gotoSettingViewController()
    }

//    @objc private func currentTimeToKoreaTime(_ sender: Timer) {
//        let currentLocationDate = Date()
//        let koreaTime = dateFormatter.string(from: currentLocationDate)
//        realTimeClockLabel.text = koreaTime
//    }

    // MARK: Change Image Method

    @objc func switchToSleepingImage() {
        pandaImageView.image = UIImage(named: "sleeping")
        statusDescriptionLabel.text = "전화 가능 시간이 아니에요."
    }

    @objc func switchToWorkingImage() {
        pandaImageView.image = UIImage(named: "working")
        statusDescriptionLabel.text = "전화 가능 시간이 아니에요."
    }

    @objc func switchToWaitingImage() {
        pandaImageView.image = UIImage(named: "waiting")
        statusDescriptionLabel.text = "전화 가능 시간이에요."
    }
}

extension TodayViewController: TodayDdayViewDelegate {

    func presentCallDelayViewController(_ type: TodayDdayView.DDayType) {
        switch type {
        case .nextGoal:
            delegate?.presentCallDelayViewController()
        case .lastCall:
            break
        }
    }
}
