//
//  TodayViewController.swift
//  Alarmi
//
//  Created by Woody on 2022/07/15.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

final class TodayViewController: UIViewController {

    // MARK: View
    
    private let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .leading
        $0.spacing = 8
        return $0
    }(UIStackView())

    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "마지막으로 전화한지 5일이 지났어요."
        $0.setDynamicFont(.title2)
        return $0
    }(UILabel())

    private let subDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "2일 후면 전화하기로 한 날이에요."
        $0.textColor = .secondaryLabel
        $0.setDynamicFont(.body)
        return $0
    }(UILabel())

    private lazy var delayButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false

        let config = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .caption2))
        let image = UIImage(systemName: "chevron.right", withConfiguration: config)
        $0.configuration?.image = image
        $0.configuration?.imagePlacement = .trailing
        $0.configuration?.baseBackgroundColor = .systemBlue
        $0.configuration?.titleAlignment = .leading
        $0.configuration?.contentInsets = .zero
        $0.addTarget(self, action: #selector(delayButtonTapped), for: .touchUpInside)

        var container = AttributeContainer()
        container.font = UIFont.preferredFont(forTextStyle: .footnote)
        $0.configuration?.attributedTitle = AttributedString("이번 연락 미루기 ", attributes: container)

        return $0
    }(UIButton(configuration: .plain()))

    private let callButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.configuration?.baseBackgroundColor = .systemBlue
        $0.configuration?.titleAlignment = .center
        $0.configuration?.cornerStyle = .medium
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        var container = AttributeContainer()
        container.font = UIFont.preferredFont(forTextStyle: .body)
        $0.configuration?.attributedTitle = AttributedString("오늘 전화 기록하기", attributes: container)

        return $0
    }(UIButton(configuration: .filled()))

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }

    // MARK: Method

    private func attribute() {
        setupNavigationBar()
    }

    private func layout() {
        view.addSubviews(stackView, callButton)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        stackView.addArrangedSubviews(descriptionLabel, subDescriptionLabel, delayButton)
        
        NSLayoutConstraint.activate([
            callButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            callButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            callButton.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width - 32)
        ])
    }
    
    private func setupNavigationBar() {
        title = "오늘"
        let image = UIImage(systemName: "gearshape")
        let barButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingButtonTapped))
        self.navigationItem.rightBarButtonItem = barButton
    }
}

extension TodayViewController {

    // MARK: Button Action

    @objc private func settingButtonTapped() {
        let settingViewController = SettingViewController()
        navigationController?.pushViewController(settingViewController, animated: true)
    }

    @objc private func delayButtonTapped() {
        let callDelayViewController = CallDelayViewController()
        let navigationController = callDelayViewController.wrappedByNavigationController()
        present(navigationController, animated: true)
    }
}
