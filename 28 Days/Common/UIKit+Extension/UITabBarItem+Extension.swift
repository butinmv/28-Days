//
//  UITabBarItem+Extension.swift
//  28 Days
//
//  Created by Maxim Butin on 15.04.2021.
//

import UIKit

extension UITabBarItem {
  
  convenience init(provider: TabBarProvider) {
    self.init(title: provider.title,
              image: provider.unselectedImage,
              selectedImage: provider.selectedImage)
  }
  
}
