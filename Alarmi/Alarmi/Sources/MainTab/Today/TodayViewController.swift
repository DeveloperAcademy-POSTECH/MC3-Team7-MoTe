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
        $0.text = "지금 한국은"
        $0.setDynamicFont(for: .body, weight: .semibold)
        return $0
    }(UILabel())

    private let statusDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "전화 가능 시간이 아니에요."
        $0.textColor = .red
        $0.setDynamicFont(for: .body, weight: .bold)
        return $0
    }(UILabel())

    private let realTimeClockLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .red
        $0.setDynamicFont(for: .largeTitle, weight: .black)
        return $0
    }(UILabel())

    private let imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        // TODO: 시간에따라 사진바꿔줘야gka
        $0.image = UIImage(named: "callTime")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

    // TODO: 내가 만들어야 하는 딜레이 버튼으로 만들어야함.
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

    // TODO: 버튼수정해야함
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
    }

    private func layout() {
        view.addSubviews(stackView, imageView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42)
        ])

        stackView.addArrangedSubviews(descriptionLabel, realTimeClockLabel, statusDescriptionLabel)

        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
        ])
    }
    
    private func setupNavigationBar() {
        title = "오늘"
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

    @objc private func delayButtonTapped() {
        delegate?.presentCallDelayViewController()
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
