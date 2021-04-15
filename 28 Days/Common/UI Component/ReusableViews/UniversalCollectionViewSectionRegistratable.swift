//
//  UniversalCollectionViewSectionRegistratable.swift
//  28 Days
//
//  Created by Maxim Butin on 16.04.2021.
//

import UIKit

protocol UniversalCollectionViewSectionRegistratable where Self: UICollectionReusableView {
  static var identifier: String { get }
  static var kind: String { get }
  static var nib: UINib { get }
  static func register(_ collectionView: UICollectionView)
  static func dequeueReusableView(_ collectionView: UICollectionView, for indexPath: IndexPath) -> Self
}

extension UniversalCollectionViewSectionRegistratable {
  
  static var identifier: String {
    String(describing: self)
  }
  
  static var nib: UINib {
    UINib(nibName: identifier, bundle: Bundle.main)
  }
  
  static func register(_ collectionView: UICollectionView) {
    collectionView.register(nib,
                            forSupplementaryViewOfKind: kind,
                            withReuseIdentifier: identifier)
  }
  
  static func dequeueReusableView(_ collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
    collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                    withReuseIdentifier: identifier,
                                                    for: indexPath) as! Self
  }
  
}
