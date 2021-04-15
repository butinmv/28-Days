//
//  String+Extension.swift
//  28 Days
//
//  Created by Maxim Butin on 15.04.2021.
//

import Foundation

extension String {
  var localize: String {
    NSLocalizedString(self, comment: "")
  }
}
