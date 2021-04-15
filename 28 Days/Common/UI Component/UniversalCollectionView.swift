//
//  UniversalCollectionView.swift
//  28 Days
//
//  Created by Maxim Butin on 16.04.2021.
//

import UIKit
import Combine

typealias UniversalCollectionViewModel =
  UniversalCollectionViewModelProtocol &
  UniversalCollectionViewOutputProtocol

protocol CollectionReusableViewModelProtocol { }

protocol CollectionSectionViewModelProtocol {
  var cells: CurrentValueSubject<[CellViewModelProtocol], Never> { get }
  var sectionHeaderViewModel: CollectionReusableViewModelProtocol? { get }
  var sectionFooterViewModel: CollectionReusableViewModelProtocol? { get }
}

protocol UniversalCollectionViewModelProtocol {
  var tableSections: [CollectionSectionViewModelProtocol] { get }
}

protocol UniversalCollectionViewOutputProtocol {
  func didSelectCell(at indexPath: IndexPath)
  func refreshData(completion: @escaping () -> ())
}

extension UniversalCollectionViewOutputProtocol {
  func didSelectCell(at indexPath: IndexPath) { }
  func refreshData(completion: @escaping () -> Void) { }
}

protocol UniversalCollectionViewSectionFactoryProtocol {
  var viewTypes: [UniversalCollectionViewSectionRegistratable.Type] { get }
  func generateView(reusableViewModel: CollectionReusableViewModelProtocol,
                    collectionView: UICollectionView,
                    indexPath: IndexPath) -> UICollectionReusableView
}

extension UniversalCollectionViewSectionFactoryProtocol {
  func registerAllViews(collectionView: UICollectionView) {
    viewTypes.forEach({ $0.register(collectionView) })
  }
}

final class UniversalCollectionView: UICollectionView {
  
  var viewModel: UniversalCollectionViewModel? {
    didSet {
      bindViewModel()
    }
  }
  
  var cellFactory: UniversalCollectionViewCellFactoryProtocol? {
    didSet {
      cellFactory?.registerAllCells(collectionView: self)
    }
  }
  
  var sectionFactory: UniversalCollectionViewSectionFactoryProtocol? {
    didSet {
      sectionFactory?.registerAllViews(collectionView: self)
    }
  }
  
  var layout: UniversalCollectionViewLayoutProtocol? {
    didSet {
      guard let collectionViewLayout = layout?.collectionViewLayout else { return }
      self.collectionViewLayout = collectionViewLayout
    }
  }
  
  private var cancellable: [AnyCancellable] = []
  
  func start() {
    self.dataSource = self
    self.delegate = self
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  private func bindViewModel() {
    viewModel?.tableSections.enumerated().forEach({ (index, section) in
      section.cells.sink(receiveValue: {  [weak self] _ in
        self?.reloadSections([index])
      }).store(in: &cancellable)
    })
  }
  
  override func reloadData() {
    super.reloadData()
    
    hideBackgroundViewIfSectionsAreEmpty()
  }
  
  override func reloadSections(_ sections: IndexSet) {
    super.reloadSections(sections)
    
    hideBackgroundViewIfSectionsAreEmpty()
  }
  
  private func hideBackgroundViewIfSectionsAreEmpty() {
    if let sections = viewModel?.tableSections {
      if sections.map({ $0.cells.value.isEmpty }).contains(false) {
        backgroundView?.isHidden = true
      } else {
        backgroundView?.isHidden = false
      }
    }
  }
  
  private func addRefreshControl() {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    self.refreshControl = refreshControl
  }
  
  private func addTapGesture() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didEndEditing))
    tapGestureRecognizer.cancelsTouchesInView = false
    self.addGestureRecognizer(tapGestureRecognizer)
  }
  
  @objc
  private func refreshData(_ sender: UIRefreshControl) {
    viewModel?.refreshData {
      sender.endRefreshing()
    }
  }
  
  @objc
  private func didEndEditing() {
    self.endEditing(true)
  }
  
}


// MARK: - UICollectionViewDataSource

extension UniversalCollectionView: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    viewModel?.tableSections.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel?.tableSections[section].cells.value.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard
      let cellViewModel = viewModel?.tableSections[indexPath.section].cells.value[indexPath.row],
      let cell = cellFactory?.generateCell(cellViewModel: cellViewModel, collectionView: collectionView, indexPath: indexPath)
    else {
      return UICollectionViewCell()
    }
    return cell
  }
  
}

// MARK: - UICollectionViewDelegate

extension UniversalCollectionView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel?.didSelectCell(at: indexPath)
  }
  
  //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
  //        let sectionViewModel = viewModel?.tableSections[indexPath.section]
  //        var reusableViewModel: CollectionReusableViewModelProtocol?
  //
  //        switch kind {
  //        case UICollectionView.elementKindSectionHeader:
  //            reusableViewModel = sectionViewModel?.sectionHeaderViewModel
  //        case UICollectionView.elementKindSectionFooter:
  //            reusableViewModel = sectionViewModel?.sectionFooterViewModel
  //        default:
  //            assert(false, "Unexpected element kind")
  //        }
  //
  //        guard
  //            let viewModel = reusableViewModel,
  //            let reusableView = sectionFactory?.generateView(reusableViewModel: viewModel, collectionView: collectionView, indexPath: indexPath)
  //        else {
  //            return UICollectionReusableView()
  //        }
  //
  //        return reusableView
  //    }
  
}

// MARK: - UICollectionViewDelegateFlowLayout

extension UniversalCollectionView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    layout?.sizeForItemAt(collectionView, indexPath: indexPath) ?? CGSize(width: 0.0, height: 0.0)
  }
  
}
