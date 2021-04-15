//
//  UniversalCollectionViewCellFactoryProtocol.swift
//  28 Days
//
//  Created by Maxim Butin on 16.04.2021.
//

import UIKit

protocol UniversalCollectionViewCellFactoryProtocol {
  var cellTypes: [UniversalCollectionViewCellRegistratable.Type] { get }
  func generateCell(cellViewModel: CellViewModelProtocol, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

extension UniversalCollectionViewCellFactoryProtocol {
  
  func registerAllCells(collectionView: UICollectionView) {
    cellTypes.forEach({ $0.register(collectionView) })
  }
  
}

