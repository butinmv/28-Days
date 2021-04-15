//
//  ProfileCoordinator.swift
//  28 Days
//
//  Created by Maxim Butin on 16.04.2021.
//

import UIKit

final class ProfileCoordinator: Coordinator {
  override func start() {
    
    let viewController = ChallengeViewController()
    
    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.tabBarItem = UITabBarItem(provider: .profile)
    
    self.viewController = navigationController
  
  }
}

