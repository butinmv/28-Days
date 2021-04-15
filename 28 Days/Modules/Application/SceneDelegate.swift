//
//  SceneDelegate.swift
//  28 Days
//
//  Created by Maxim Butin on 15.04.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  
  private var rootCoordinator: Coordinator?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = windowScene.windows.first
    
    setupRootCoordinator()
  }
  
  private func setupRootCoordinator() {
    rootCoordinator = RootCoordinator(window: window!)
    rootCoordinator?.start()
  }

}

