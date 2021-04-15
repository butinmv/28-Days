//
//  UniversalCollectionSectionViewModel.swift
//  28 Days
//
//  Created by Maxim Butin on 16.04.2021.
//

import Foundation
import Combine

final class UniversalCollectionSectionViewModel: CollectionSectionViewModelProtocol {
  
  // MARK: - Public properties
  
  var sectionHeaderViewModel: CollectionReusableViewModelProtocol?
  var sectionFooterViewModel: CollectionReusableViewModelProtocol?
  var cells: CurrentValueSubject<[CellViewModelProtocol], Never>
  
  // MARK: - Init
  
  init(sectionHeaderViewModel: CollectionReusableViewModelProtocol? = nil,
       sectionFooterViewModel: CollectionReusableViewModelProtocol? = nil,
       cells: [CellViewModelProtocol]) {
    self.sectionHeaderViewModel = sectionHeaderViewModel
    self.sectionFooterViewModel = sectionFooterViewModel
    self.cells = .init(cells)
  }
  
}
