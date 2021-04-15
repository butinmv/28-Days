//
//  ChallengeCoordinator.swift
//  28 Days
//
//  Created by Maxim Butin on 15.04.2021.
//

import UIKit

final class ChallengeCoordinator: Coordinator {
  override func start() {
    
    let viewController = ChallengeViewController()
    
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.tabBarItem = UITabBarItem(provider: .challenge)
    
    self.viewController = navigationController
  
  }
}
