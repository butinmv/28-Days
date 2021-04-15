//
//  RootCoordinator.swift
//  28 Days
//
//  Created by Maxim Butin on 15.04.2021.
//

import UIKit

final class RootCoordinator: Coordinator {
  
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
    
    super.init(parentViewController: nil)
  }
  
  override func start() {
    let viewModel = RootViewModel(router: self)
    
    let viewController = RootTabBarController()
    viewController.viewModel = viewModel
    
    self.viewController = viewController
    
    window.rootViewController = viewController
    window.becomeKey()
  }
  
}
