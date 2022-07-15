//
//  UITabBarItem+.swift
//  Alarmi
//
//  Created by Woody on 2022/07/15.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit

extension UITabBarItem {
    
    convenience init(item: MainTabBarController.TabItem) {
        let image = UIImage(systemName: item.imageName)
        self.init(title: item.title, image: image, selectedImage: nil)
    }
}
