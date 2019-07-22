//
//  TreeTableViewDelegate.swift
//  TreeTableView
//
//  Created by Anton Lisovoy on 21/07/2019.
//  Copyright © 2019 Anton Lisovoy. All rights reserved.
//

import UIKit

public protocol TreeTableViewDelegate: UIScrollViewDelegate {
  // MARK: Required Methods
  func treeTableView(_ treeTableView: TreeTableView, cellForRowAt indexPath: IndexPath, node: Node) -> UITableViewCell

  // MARK: Optional Methods
  func treeTableView(_ treeTableView: TreeTableView, didSelectRowAt indexPath: IndexPath, node: Node)
  func treeTableView(_ treeTableView: TreeTableView, didExpandRowAt indexPath: IndexPath, node: Node)
  func treeTableView(_ treeTableView: TreeTableView, didCollapseRowAt indexPath: IndexPath, node: Node)
  func treeTableView(_ treeTableView: TreeTableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  func treeTableView(_ treeTableView: TreeTableView, titleForHeaderInSection section: Int) -> String?
  func treeTableView(_ treeTableView: TreeTableView, heightForHeaderInSection section: Int) -> CGFloat
  func treeTableView(_ treeTableView: TreeTableView, viewForHeaderInSection section: Int) -> UIView?
  func treeTableView(_ treeTableView: TreeTableView, heightForFooterInSection section: Int) -> CGFloat
  func treeTableView(_ treeTableView: TreeTableView, viewForFooterInSection section: Int) -> UIView?
  func treeTableView(_ treeTableView: TreeTableView, titleForFooterInSection section: Int) -> String?
  func treeTableView(_ treeTableView: TreeTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
  func treeTableView(_ treeTableView: TreeTableView, didEndDisplaying cell: UITableViewCell, forRow indexPath: IndexPath)
  func treeTableView(_ treeTableView: TreeTableView, willDisplayHeaderView view: UIView, forSection section: Int)
  func treeTableView(_ treeTableView: TreeTableView, willDisplayFooterView view: UIView, forSection section: Int)
  func treeTableView(_ treeTableView: TreeTableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
  func treeTableView(_ treeTableView: TreeTableView, didHighlightRowAt indexPath: IndexPath)
  func treeTableView(_ treeTableView: TreeTableView, didUnhighlightRowAt indexPath: IndexPath)
}

public extension TreeTableViewDelegate {
  func treeTableView(_ treeTableView: TreeTableView, didSelectRowAt indexPath: IndexPath, node: Node) { }
  func treeTableView(_ treeTableView: TreeTableView, didExpandRowAt indexPath: IndexPath, node: Node) { }
  func treeTableView(_ treeTableView: TreeTableView, didCollapseRowAt indexPath: IndexPath, node: Node) { }
  func treeTableView(_ treeTableView: TreeTableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return UITableView.automaticDimension }
  func treeTableView(_ treeTableView: TreeTableView, titleForHeaderInSection section: Int) -> String? { return nil }
  func treeTableView(_ treeTableView: TreeTableView, heightForHeaderInSection section: Int) -> CGFloat { return 0 }
  func treeTableView(_ treeTableView: TreeTableView, viewForHeaderInSection section: Int) -> UIView? { return nil }
  func treeTableView(_ treeTableView: TreeTableView, heightForFooterInSection section: Int) -> CGFloat { return 0 }
  func treeTableView(_ treeTableView: TreeTableView, viewForFooterInSection section: Int) -> UIView? { return nil }
  func treeTableView(_ treeTableView: TreeTableView, titleForFooterInSection section: Int) -> String? { return nil }
  func treeTableView(_ treeTableView: TreeTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { }
  func treeTableView(_ treeTableView: TreeTableView, didEndDisplaying cell: UITableViewCell, forRow indexPath: IndexPath) { }
  func treeTableView(_ treeTableView: TreeTableView, willDisplayHeaderView view: UIView, forSection section: Int) { }
  func treeTableView(_ treeTableView: TreeTableView, willDisplayFooterView view: UIView, forSection section: Int) { }
  func treeTableView(_ treeTableView: TreeTableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool { return true }
  func treeTableView(_ treeTableView: TreeTableView, didHighlightRowAt indexPath: IndexPath) { }
  func treeTableView(_ treeTableView: TreeTableView, didUnhighlightRowAt indexPath: IndexPath) { }
}
