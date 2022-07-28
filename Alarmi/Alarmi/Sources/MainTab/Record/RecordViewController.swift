//
//  RecordViewController.swift
//  Alarmi
//
//  Created by Woody on 2022/07/27.
//  Copyright (c) 2022 MoTe. All rights reserved.
//

import Combine
import UIKit
import SwiftUI

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

    private lazy var purposeContainerView: PurposeContainerView = {
        let view = PurposeContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var recentAchieveContainerView: RecentAchieveContainerView = {
        let view = RecentAchieveContainerView()
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
        viewModel.viewDidLoad()
    }

    // MARK: Method

    func bind() {
        viewModel.$purpose
            .receive(on: DispatchQueue.main)
            .sink { [weak self] viewModel in
                self?.purposeContainerView.viewModel = viewModel
            }
            .store(in: &cancelBag)

        viewModel.$achievement
            .receive(on: DispatchQueue.main)
            .sink { [weak self] viewModel in
                self?.recentAchieveContainerView.viewModel = viewModel
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
        contentView.addSubview(purposeContainerView)
        contentView.addSubview(recentAchieveContainerView)

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
            purposeContainerView.topAnchor.constraint(equalTo: frequencyContainerView.bottomAnchor, constant: 16),
            purposeContainerView.leadingAnchor.constraint(equalTo: frequencyContainerView.leadingAnchor),
            purposeContainerView.trailingAnchor.constraint(equalTo: frequencyContainerView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            recentAchieveContainerView.topAnchor.constraint(equalTo: purposeContainerView.bottomAnchor, constant: 16),
            recentAchieveContainerView.leadingAnchor.constraint(equalTo: frequencyContainerView.leadingAnchor),
            recentAchieveContainerView.trailingAnchor.constraint(equalTo: frequencyContainerView.trailingAnchor)
        ])
    }
}
