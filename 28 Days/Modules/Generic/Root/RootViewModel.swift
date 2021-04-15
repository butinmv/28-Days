//
//  RootViewModel.swift
//  28 Days
//
//  Created by Maxim Butin on 15.04.2021.
//

import Foundation

protocol RootViewModelInputProtocol {
  func getTabBarCoordinators() -> [Coordinator]
}

final class RootViewModel {
  
  private let router: RootCoordinator
  
  init(router: RootCoordinator) {
    self.router = router
  }
  
}

extension RootViewModel: RootViewModelInputProtocol {
  
  func getTabBarCoordinators() -> [Coordinator] {
    TabBarProvider.allCases.map({
      $0.generateCoordinator(parentViewController: nil)
    })
  }

}
