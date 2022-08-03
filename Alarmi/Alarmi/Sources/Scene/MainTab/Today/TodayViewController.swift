//
//  TodayViewController.swift
//  Alarmi
//
//  Created by Woody on 2022/07/15.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Combine
import UIKit

protocol TodayViewControllerDelegate: AnyObject {
    func gotoSettingViewControllerFromTodayView()
    func presentCallDelayViewController()
}

final class TodayViewController: UIViewController {

    // MARK: View

    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "지금 한국은"
        $0.textAlignment = .left
        $0.setDynamicFont(for: .body, weight: .semibold)
        $0.textColor = .tintColor
        return $0
    }(UILabel())

    private lazy var koreaTimeLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.text = Formatter.HHMMKoreaDateFormatter.string(from: Date())
        $0.setDynamicFont(for: .largeTitle, weight: .black)
        $0.font = .systemFont(ofSize: 108, weight: .black)
        $0.textColor = .tintColor
        return $0
    }(UILabel())

    private let statusDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .right
        $0.setDynamicFont(for: .body, weight: .semibold)
        $0.textColor = .tintColor
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
        $0.spacing = 32
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

    var viewModel: TodayViewModel!
    private var cancellable = Set<AnyCancellable>()
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        attribute()
        layout()
        viewModel.viewDidLoad.send()
    }

    // MARK: Method

    private func attribute() {
        view.backgroundColor = .backgroundColor
        setupNavigationBar()
    }

    private func bind() {

        viewModel.$todayKoreaState
            .map { $0.todayModel }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.pandaImageView.image = UIImage(named: $0.imageName)
                self?.statusDescriptionLabel.text = $0.description
            }.store(in: &cancellable)

        TimerManager.shared.timer
            .autoconnect()
            .map { $0.judgeKoreaState().todayModel }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.pandaImageView.image = UIImage(named: $0.imageName)
                self?.statusDescriptionLabel.text = $0.description
            }.store(in: &cancellable)

        TimerManager.shared.timer
            .autoconnect()
            .map { Formatter.HHMMKoreaDateFormatter.string(from: $0) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.koreaTimeLabel.text = $0
            }.store(in: &cancellable)

        viewModel.$lastCallDDay
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.lastCallDDayView.update(with: $0)
            }.store(in: &cancellable)

        viewModel.$goaldDay
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.nextGoalDDayView.update(with: $0)
            }.store(in: &cancellable)

        viewModel.$todayDidCall
            .receive(on: DispatchQueue.main)
            .sink { [weak self] didCall in
                self?.lastCallDDayView.updateButton(didCall)
            }.store(in: &cancellable)
    }

    private func layout() {
        view.addSubviews(descriptionLabel, koreaTimeLabel, statusDescriptionLabel)
        view.addSubviews(pandaImageBoardView, dDayStackView)

        pandaImageBoardView.addSubview(pandaImageView)

        dDayStackView.addArrangedSubviews(lastCallDDayView, nextGoalDDayView)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: koreaTimeLabel.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: koreaTimeLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: koreaTimeLabel.trailingAnchor),

            koreaTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            koreaTimeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),

            statusDescriptionLabel.bottomAnchor.constraint(equalTo: koreaTimeLabel.bottomAnchor),
            statusDescriptionLabel.leadingAnchor.constraint(equalTo: koreaTimeLabel.leadingAnchor),
            statusDescriptionLabel.trailingAnchor.constraint(equalTo: koreaTimeLabel.trailingAnchor),

            pandaImageBoardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pandaImageBoardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            pandaImageView.centerXAnchor.constraint(equalTo: pandaImageBoardView.centerXAnchor),
            pandaImageView.centerYAnchor.constraint(equalTo: pandaImageBoardView.centerYAnchor),
            pandaImageView.widthAnchor.constraint(equalToConstant: 200),

            dDayStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            dDayStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let image = UIImage(systemName: "gearshape")
        let barButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingButtonTapped))
        self.navigationItem.rightBarButtonItem = barButton
        navigationItem.largeTitleDisplayMode = .never
        title = "오늘"
        navigationItem.titleView = UIView()
    }

    @objc private func settingButtonTapped() {
        delegate?.gotoSettingViewControllerFromTodayView()
    }
}

extension TodayViewController: TodayDdayViewDelegate {

    func buttonDidTap(_ type: TodayDdayView.DDayType) {
        switch type {
        case .nextGoal: // 미루기 버튼
            delegate?.presentCallDelayViewController()
        case .lastCall: // 전화했어요 버튼
            viewModel?.didCallButtonTapped.send()
        case .delay:
            delegate?.presentCallDelayViewController()
        }
    }
}
