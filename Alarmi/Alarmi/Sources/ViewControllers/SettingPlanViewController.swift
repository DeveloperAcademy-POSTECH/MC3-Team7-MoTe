//
//  SettingPlanViewController.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/18.
//  Copyright © 2022 MoTe. All rights reserved.
//

import Foundation
import UIKit

class SettingPlanViewController: UIViewController {
    
    @IBOutlet var containerViews: [UIView]!
    @IBOutlet var settingDayLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
    }
    
    private func attribute() {
        containerViews.forEach {
            $0.layer.cornerRadius = 15
            $0.layer.masksToBounds = true
        }
        
    }
    
    @IBAction func settingDaySlider(_ sender: UISlider) {
        let value = sender.value
        settingDayLabel.text = String(Int(value)) + "일에 한 번 전화할게요."
    }
}
