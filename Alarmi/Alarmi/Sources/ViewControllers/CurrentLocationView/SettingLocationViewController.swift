//
//  CurrentLocationViewController.swift
//  Alarmi
//
//  Created by LeeJiSoo on 2022/07/16.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

class SettingLocationViewController: UIViewController {

    // MARK: View

    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "지금 어디에 계신가요?"
        $0.setDynamicFont(.body)
        return $0
    }(UILabel())

    private lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(SettingLocationCollectionViewCell.self, forCellWithReuseIdentifier: "SettingLocationCollectionViewCell")
        $0.backgroundColor = .systemGroupedBackground
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))

    // MARK: property

    let columns: CGFloat = 2
    let countryFlag = ["🇺🇸", "🇨🇳", "🇦🇺", "🇯🇵", "🇨🇦", "🇧🇪", "🇫🇷"]
    let countryName = ["미국", "중국", "호주", "일본", "캐나다", "독일", "프랑스"]
    let countryTime = ["도시마다 달라요", "한국보다 -1시간", "한국보다 +1시간", "한국보다 +0시간", "도시마다 달라요", "한국보다 -7시간", "한국보다 -7시간"]

    // MARK: cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }

    // MARK: - method

    private func attribute() {
//        collectionView.collectionViewLayout = createCompositionalLayoutForFirst()
        setupNavigationBar()
        setup()
    }

    private func setup() {
        view.backgroundColor = .systemGroupedBackground
    }

    private func layout() {
        view.addSubviews(collectionView, descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            collectionView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        ])
    }

    private func setupNavigationBar() {
        title = "현재 위치"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: protocols

extension SettingLocationViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width / columns) - 10
        let height = 120.0
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension SettingLocationViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryFlag.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingLocationCollectionViewCell", for: indexPath) as? SettingLocationCollectionViewCell
        cell?.setup()
        cell?.layer.cornerRadius = 15.0
        cell?.backgroundColor = .secondarySystemGroupedBackground
        cell?.flagLabel.text = countryFlag[indexPath.row]
        cell?.nameLabel.text = countryName[indexPath.row]
        cell?.compareTimeLabel.text = countryTime[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
}

// MARK: Preview

#if DEBUG
import SwiftUI

struct SettingViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: SettingLocationViewController())
            .toPreview()
            .ignoresSafeArea()
    }
}
#endif
