//
//  StatisticCoordinator.swift
//  28 Days
//
//  Created by Maxim Butin on 16.04.2021.
//

import UIKit

final class StaticticCoordinator: Coordinator {
  override func start() {
    
    let viewController = StatisticViewController()
    
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.tabBarItem = UITabBarItem(provider: .statistic)
    
    self.viewController = navigationController
  
  }
}
