//
//  TreeTableViewController.swift
//  TreeTableViewDemo
//
//  Created by Anton Lisovoy on 21/07/2019.
//  Copyright © 2019 Anton Lisovoy. All rights reserved.
//

import TreeTableView

class TreeTableViewController: UIViewController {

  @IBOutlet private weak var treeTableView: TreeTableView!

  private var categories: [Category] = [Category(name: "iOS",
                                         subcategories: [Category(name: "iPhone",
                                                                  subcategories: [Category(name: "iPhone XS", subcategories: []),
                                                                                  Category(name: "iPhone XS Max", subcategories: []),
                                                                                  Category(name: "iPhone XR", subcategories: [])]),
                                                         Category(name: "iPad",
                                                                  subcategories: [Category(name: "iPad (6th generation)", subcategories: []),
                                                                                  Category(name: "iPad Pro (11-inch)", subcategories: []),
                                                                                  Category(name: "iPad Pro (12.9-inch)", subcategories: [])]),
                                                         Category(name: "iPod",
                                                                  subcategories: [Category(name: "iPod touch (6th generation)", subcategories: [])])]),
                                Category(name: "macOS",
                                         subcategories: [Category(name: "Desktops",
                                                                  subcategories: [Category(name: "iMac",
                                                                                           subcategories: [Category(name: "iMac (Retina 4K, 21.5-inch)",
                                                                                                                    subcategories: []),
                                                                                                           Category(name: "iMac (Retina 5K, 27-inch)",
                                                                                                                    subcategories: []),
                                                                                                           Category(name: "iMac Pro",
                                                                                                                    subcategories: [])]),
                                                                                  Category(name: "Mac mini",
                                                                                           subcategories: [Category(name: "Mac mini",
                                                                                                                    subcategories: [])]),
                                                                                  Category(name: "Mac Pro",
                                                                                           subcategories: [Category(name: "Mac Pro",
                                                                                                                    subcategories: [])])]),
                                                         Category(name: "Notebooks",
                                                                  subcategories: [Category(name: "MacBook",
                                                                                           subcategories: [Category(name: "MacBook",
                                                                                                                    subcategories: [])]),
                                                                                  Category(name: "MacBook Air",
                                                                                           subcategories: [Category(name: "MacBook Air (11-inch)",
                                                                                                                    subcategories: []),
                                                                                                           Category(name: "MacBook Air (13-inch)",
                                                                                                                    subcategories: []),
                                                                                                           Category(name: "MacBook Air (Retina, 13-inch)",
                                                                                                                    subcategories: [])]),
                                                                                  Category(name: "MacBook Pro",
                                                                                           subcategories: [Category(name: "MacBook Pro (13-inch)",
                                                                                                                    subcategories: []),
                                                                                                           Category(name: "MacBook Pro (15-inch)",
                                                                                                                    subcategories: [])])])])]
  private var nodes: [Node] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    configureTreeTableView()
  }

  private func configureTreeTableView() {
    treeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    treeTableView.treeDataSource = self
    treeTableView.treeDelegate = self
    treeTableView.tableFooterView = UIView()
  }

  private func addNode(from category: Category) {
    let node = Node(name: category.name)
    nodes.append(node)
    category.subcategories.forEach {
      addSubnodes(from: $0, to: node)
    }
  }

  private func addSubnodes(from category: Category, to parentNode: Node) {
    let node = Node(name: category.name)
    node.parentNode = parentNode
    nodes.append(node)
    category.subcategories.forEach {
      addSubnodes(from: $0, to: node)
    }
  }

}

//MARK: - TreeTableViewDataSource implementationn
extension TreeTableViewController: TreeTableViewDataSource {
  func configureNodes() -> [Node] {
    categories.forEach {
      addNode(from: $0)
    }
    return nodes
  }
}

//MARK: - TreeTableViewDelegate implementationn
extension TreeTableViewController: TreeTableViewDelegate {
  func treeTableView(_ treeTableView: TreeTableView, cellForRowAt indexPath: IndexPath, node: Node) -> UITableViewCell {
    let cell = treeTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = node.name
    let inset = 25 * node.depth
    cell.layoutMargins = UIEdgeInsets(top: 0, left: CGFloat(inset), bottom: 0, right: 0)
    return cell
  }

  func treeTableView(_ treeTableView: TreeTableView, didExpandRowAt indexPath: IndexPath, node: Node) {
    treeTableView.deselectRow(at: indexPath, animated: true)
    print("Did expand node '\(node.name)' at indexPath \(indexPath)")
  }

  func treeTableView(_ treeTableView: TreeTableView, didCollapseRowAt indexPath: IndexPath, node: Node) {
    treeTableView.deselectRow(at: indexPath, animated: true)
    print("Did collapse node '\(node.name)' at indexPath \(indexPath)")
  }

  func treeTableView(_ treeTableView: TreeTableView, didSelectRowAt indexPath: IndexPath, node: Node) {
    treeTableView.deselectRow(at: indexPath, animated: true)
    print("Did select node '\(node.name)' at indexPath \(indexPath)")
  }

}
