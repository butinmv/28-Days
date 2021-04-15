//
//  CoordinatorClosableProtocol.swift
//  28 Days
//
//  Created by Maxim Butin on 15.04.2021.
//

import Foundation

protocol CoordinatorClosableProtocol {
  func close(completion: (() -> ())?)
  func close()
}

extension CoordinatorClosableProtocol where Self: Coordinator {
  
  func close(completion: (() -> ())?) {
    viewController?.dismiss(animated: true, completion: completion)
  }
  
  func close() {
    close(completion: nil)
  }
}
