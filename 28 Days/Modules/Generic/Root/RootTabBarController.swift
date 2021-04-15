//
//  RootTabBarControllerViewController.swift
//  28 Days
//
//  Created by Maxim Butin on 16.04.2021.
//

import UIKit

class RootTabBarController: UITabBarController {
  
  var viewModel: RootViewModelInputProtocol? {
    didSet {
      bindViewModel()
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
  private func bindViewModel() {
      viewControllers = viewModel?.getTabBarCoordinators().compactMap({
          $0.start()
          return $0.viewController
      })
  }
  
}
