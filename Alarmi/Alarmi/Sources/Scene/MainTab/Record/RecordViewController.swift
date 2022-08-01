//
//  RecordViewController.swift
//  Alarmi
//
//  Created by Woody on 2022/07/27.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import UIKit

final class RecordViewController: UIViewController {

    // MARK: View

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()

    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private lazy var frequencyContainerView: FrequencyContainerView = {
        let view = FrequencyContainerView()
        view.parentViewController = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()

    private lazy var purposeBoardView: PurposeBoardView = {
        let view = PurposeBoardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var recordGoalBoardView: RecordGoalBoardView = {
        let view = RecordGoalBoardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Store Property

    var viewModel: RecordViewModel!
    private var cancelBag = Set<AnyCancellable>()

    // MARK: LifeCycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        attribute()
        layout()

        viewModel.viewDidLoad.send()
    }

    // MARK: Method

    func bind() {
        viewModel.$goalCombo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.purposeBoardView.goalCombo = $0
            }
            .store(in: &cancelBag)

        viewModel.$goalCount
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.purposeBoardView.goalCount = $0
            }
            .store(in: &cancelBag)

        viewModel.$goalCircleList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.recordGoalBoardView.updateCircleViews(with: $0)
            }
            .store(in: &cancelBag)

        viewModel.$goalPercent
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.recordGoalBoardView.updateGoalPercentLabel(with: $0)
            }
            .store(in: &cancelBag)

        viewModel.$frequencyDateList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] dataList in
                self?.frequencyContainerView.frequencyDataList = dataList
            }
            .store(in: &cancelBag)
    }

    func attribute() {
        view.backgroundColor = .systemGroupedBackground
        title = "기록"
    }

    func layout() {
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubview(frequencyContainerView)
        contentView.addSubview(purposeBoardView)
        contentView.addSubview(recordGoalBoardView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        let heightConstraint = contentView.heightAnchor.constraint(equalToConstant: 600)
        heightConstraint.priority = UILayoutPriority(250)
        heightConstraint.isActive = true
        NSLayoutConstraint.activate([
            frequencyContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            frequencyContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            frequencyContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            purposeBoardView.topAnchor.constraint(equalTo: frequencyContainerView.bottomAnchor, constant: 16),
            purposeBoardView.leadingAnchor.constraint(equalTo: frequencyContainerView.leadingAnchor),
            purposeBoardView.trailingAnchor.constraint(equalTo: frequencyContainerView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            recordGoalBoardView.topAnchor.constraint(equalTo: purposeBoardView.bottomAnchor, constant: 16),
            recordGoalBoardView.leadingAnchor.constraint(equalTo: frequencyContainerView.leadingAnchor),
            recordGoalBoardView.trailingAnchor.constraint(equalTo: frequencyContainerView.trailingAnchor)
        ])
    }
}
