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

    var viewModel: TodayViewModel!
    private var cancellable = Set<AnyCancellable>()
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        attribute()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.viewWillAppear.send()
    }

    // MARK: Method

    private func attribute() {
        view.backgroundColor = .systemGroupedBackground
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

        viewModel.$lastCall
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.lastCallDDayView.update(with: $0)
            }.store(in: &cancellable)

        viewModel.$nextGoal
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

    @objc private func settingButtonTapped() {
        delegate?.gotoSettingViewController()
    }
}

extension TodayViewController: TodayDdayViewDelegate {

    func buttonDidTap(_ type: TodayDdayView.DDayType) {
        switch type {
        case .nextGoal: // 미루기 버튼
            delegate?.presentCallDelayViewController()
        case .lastCall: // 전화했어요 버튼
            viewModel?.didCallButtonTapped.send()
        }
    }
}
