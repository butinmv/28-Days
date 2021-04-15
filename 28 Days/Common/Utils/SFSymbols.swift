//
//  SFSymbols.swift
//  28 Days
//
//  Created by Maxim Butin on 15.04.2021.
//

import UIKit

enum ImageState {
  case normal
  case fill
}

struct SFSymbols {
  
  private init() { }
  
  static func house(for state: ImageState = .normal) -> UIImage {
    switch state {
    case .normal:
      return UIImage(systemName: "house.fill")!
    case .fill:
      return UIImage(systemName: "house")!
    }
  }
  
  static func statictics(for state: ImageState = .normal) -> UIImage {
    switch state {
    case .normal:
      return UIImage(systemName: "chart.bar")!
    case .fill:
      return UIImage(systemName: "chart.bar.fill")!
    }
  }
  
  static func profile(for state: ImageState = .normal) -> UIImage {
    switch state {
    case .normal:
      return UIImage(systemName: "person")!
    case .fill:
      return UIImage(systemName: "person.fill")!
    }
  }
  
}
