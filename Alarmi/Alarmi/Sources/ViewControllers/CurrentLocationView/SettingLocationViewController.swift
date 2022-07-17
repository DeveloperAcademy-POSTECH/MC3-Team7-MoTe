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
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
}
