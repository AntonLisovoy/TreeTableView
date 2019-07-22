//
//  TreeTableProcessor.swift
//  TreeTableView
//
//  Created by Anton Lisovoy on 21/07/2019.
//  Copyright © 2019 Anton Lisovoy. All rights reserved.
//

import Foundation

class TreeTableProcessor {
  var nodes: [Node] = [] {
    didSet {
      processedNodes.removeAll()
      nodes.filter { $0.parentNode == nil }.forEach { addExpandNode(node: $0) }
    }
  }
  private(set) var processedNodes: [Node] = []
  private(set) var indexPathsToInsert: [IndexPath] = []
  private(set) var indexPathsToDelete: [IndexPath] = []

  func addExpandNode(node: Node) {
    processedNodes.append(node)

    if node.isExpand {
      node.subNodes.forEach {
        addExpandNode(node: $0)
      }
    }
  }

  func isLeafNode(node: Node) -> Bool {
    return node.subNodes.isEmpty
  }

  func clearIndexPathsToInsert() {
    indexPathsToInsert.removeAll()
  }

  func insertChildNode(node: Node) {
    node.expand()
    guard !node.subNodes.isEmpty else { return }

    var insertRow = (processedNodes.firstIndex(of: node) ?? 0) + 1

    node.subNodes.forEach {
      let sections = indexPathsToInsert.compactMap { $0.section }
      if sections.contains(insertRow) {
        insertRow = (sections.last ?? 0) + 1
      }
      let childIndexPath = IndexPath(row: 0, section: insertRow)
      indexPathsToInsert.append(childIndexPath)

      processedNodes.insert($0, at: insertRow)

      insertRow += 1
      if $0.isExpand {
        insertChildNode(node: $0)
      }
    }
  }

  func getDeleteIndexPaths(node: Node) {
    guard node.isExpand else { return }
    node.subNodes.forEach {
      let childRow = processedNodes.firstIndex(of: $0) ?? 0
      let childIndexPath = IndexPath(row: 0, section: childRow)
      indexPathsToDelete.append(childIndexPath)

      if $0.isExpand {
        getDeleteIndexPaths(node: $0)
      }
    }
  }

  func clearIndexPathsToDelete() {
    indexPathsToDelete.removeAll()
  }

  func deleteChildNode(node: Node) {
    getDeleteIndexPaths(node: node)

    node.collaps()

    let sections = indexPathsToDelete.compactMap { $0.section }
    var nodesToDelete: [Node] = []
    sections.forEach {
      nodesToDelete.append(processedNodes[$0])
    }
    processedNodes.removeAll(where: { nodesToDelete.contains($0) })
  }

}
