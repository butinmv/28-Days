//
//  UniversalCollectionViewLayoutProtocol.swift
//  28 Days
//
//  Created by Maxim Butin on 16.04.2021.
//

import UIKit

protocol UniversalCollectionViewLayoutProtocol {
    var collectionViewLayout: UICollectionViewFlowLayout { get }
    func sizeForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize
}
