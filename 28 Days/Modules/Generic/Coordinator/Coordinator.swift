//
//  Coordinator.swift
//  28 Days
//
//  Created by Maxim Butin on 15.04.2021.
//

import UIKit

class Coordinator {
  
  var completion: (() -> ())?
  
  internal weak var parentViewController: UIViewController?
  internal weak var viewController: UIViewController?
  
  init(parentViewController: UIViewController?) {
    self.parentViewController = parentViewController
  }
  
  deinit {
    completion?()
  }
  
  internal func start() {
    assertionFailure("start() method isn't implemented")
  }
}
