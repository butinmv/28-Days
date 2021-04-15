//
//  TabBarProvider.swift
//  28 Days
//
//  Created by Maxim Butin on 15.04.2021.
//

import UIKit

enum TabBarProvider: Int, CaseIterable {
  case challenge
  case statistic
  case profile
  
  var title: String {
    switch self {
    case .challenge:
      return "Home".localize
    case .statistic:
      return "Statistic".localize
    case .profile:
      return "Profile".localize
    }
  }
  
  var unselectedImage: UIImage {
    switch self {
    case .challenge:
      return SFSymbols.house(for: .fill)
    case .statistic:
      return SFSymbols.statictics()
    case .profile:
      return SFSymbols.profile()
    }
  }
  
  var selectedImage: UIImage {
    switch self {
    case .challenge:
      return SFSymbols.house()
    case .statistic:
      return SFSymbols.statictics(for: .fill)
    case .profile:
      return SFSymbols.profile(for: .fill)
      
    }
  }
  
  func generateCoordinator(parentViewController: UIViewController?) -> Coordinator {
    switch self {
    case .challenge:
      return ChallengeCoordinator(parentViewController: parentViewController)
    case .statistic:
      return StaticticCoordinator(parentViewController: parentViewController)
    case .profile:
      return ProfileCoordinator(parentViewController: parentViewController)
    }
  }
}
