//
//  TreeTableView.swift
//  TreeTableView
//
//  Created by Anton Lisovoy on 20/07/2019.
//  Copyright © 2019 Anton Lisovoy. All rights reserved.
//

import UIKit

public class TreeTableView: UITableView {

  public weak var treeDataSource: TreeTableViewDataSource? {
    didSet {
      self.dataSource = self
      guard let dataSource = treeDataSource else { return }
      let nodes = dataSource.configureNodes()
      processor.nodes = nodes
    }
  }
  public weak var treeDelegate: TreeTableViewDelegate? {
    didSet {
      self.delegate = self
    }
  }
  private let processor = TreeTableProcessor()

}

//MARK: - UITableViewDataSource implementationn
extension TreeTableView: UITableViewDataSource {
  public func numberOfSections(in tableView: UITableView) -> Int {
    guard treeDelegate != nil else { return 0 }
    return processor.processedNodes.count
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard treeDelegate != nil else { return 0 }
    return 1
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let delegate = treeDelegate else { fatalError("treeDelegate must not be nil") }
    let node = processor.processedNodes[indexPath.section]
    return delegate.treeTableView(self, cellForRowAt: indexPath, node: node)
  }
}

//MARK: - UITableViewDelegate implementationn
extension TreeTableView: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let delegate = treeDelegate else { return }
    let node = processor.processedNodes[indexPath.section]
    guard !processor.isLeafNode(node: node) else {
      delegate.treeTableView(self, didSelectRowAt: indexPath, node: node)
      return
    }
    guard node.isExpand else {
      processor.clearIndexPathsToInsert()
      processor.insertChildNode(node: node)
      var indexSet = IndexSet()
      processor.indexPathsToInsert.forEach { indexSet.update(with: $0.section) }
      CATransaction.begin()
      CATransaction.setCompletionBlock {
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
      }
      tableView.insertSections(indexSet, with: .top)
      CATransaction.commit()
      delegate.treeTableView(self, didExpandRowAt: indexPath, node: node)
      return
    }
    processor.clearIndexPathsToDelete()
    processor.deleteChildNode(node: node)
    var indexSet = IndexSet()
    processor.indexPathsToDelete.forEach { indexSet.update(with: $0.section) }
    tableView.deleteSections(indexSet, with: .top)
    delegate.treeTableView(self, didCollapseRowAt: indexPath, node: node)
  }

  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let delegate = treeDelegate else { return UITableView.automaticDimension }
    return delegate.treeTableView(self, heightForRowAt: indexPath)
  }

  public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let delegate = treeDelegate else { return nil }
    return delegate.treeTableView(self, titleForHeaderInSection: section)
  }

  public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard let delegate = treeDelegate else { return 0 }
    return delegate.treeTableView(self, heightForHeaderInSection: section)
  }

  public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let delegate = treeDelegate else { return nil }
    return delegate.treeTableView(self, viewForHeaderInSection: section)
  }

  public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    guard let delegate = treeDelegate else { return 0 }
    return delegate.treeTableView(self, heightForFooterInSection: section)
  }

  public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let delegate = treeDelegate else { return nil }
    return delegate.treeTableView(self, viewForFooterInSection: section)
  }
  public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    guard let delegate = treeDelegate else { return nil }
    return delegate.treeTableView(self, titleForFooterInSection: section)
  }

  @objc(tableView:willDisplayCell:forRowAtIndexPath:) public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let delegate = treeDelegate else { return }
    delegate.treeTableView(self, willDisplay: cell, forRowAt: indexPath)
  }

  public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let delegate = treeDelegate else { return }
    delegate.treeTableView(self, didEndDisplaying: cell, forRow: indexPath)
  }

  public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let delegate = treeDelegate else { return }
    return delegate.treeTableView(self, willDisplayHeaderView: view, forSection: section)
  }

  public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
    guard let delegate = treeDelegate else { return }
    return delegate.treeTableView(self, willDisplayFooterView: view, forSection: section)
  }

  public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    guard let delegate = treeDelegate else { return false }
    return delegate.treeTableView(self, shouldHighlightRowAt: indexPath)
  }

  public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    guard let delegate = treeDelegate else { return }
    return delegate.treeTableView(self, didHighlightRowAt: indexPath)
  }

  public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
    guard let delegate = treeDelegate else { return }
    return delegate.treeTableView(self, didUnhighlightRowAt: indexPath)
  }

  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewDidScroll?(scrollView)
  }

  public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewDidScrollToTop?(scrollView)
  }

  public func scrollViewDidZoom(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewDidZoom?(scrollView)
  }
  public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
    treeDelegate?.scrollViewWillBeginZooming?(scrollView, with: view)
  }

  public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
    treeDelegate?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
  }

  public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewWillBeginDragging?(scrollView)
  }
  public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    treeDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
  }

  public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    treeDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity:velocity, targetContentOffset: targetContentOffset)
  }

  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewDidEndDecelerating?(scrollView)
  }

  public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
  }

  public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewWillBeginDecelerating?(scrollView)
  }

  public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
    return treeDelegate?.scrollViewShouldScrollToTop?(scrollView) ?? false
  }

  @available(iOS 11.0, *)
  public func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
    treeDelegate?.scrollViewDidChangeAdjustedContentInset?(scrollView)
  }
}
