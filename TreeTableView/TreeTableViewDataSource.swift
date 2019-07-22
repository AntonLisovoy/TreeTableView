//
//  TreeTableViewDataSource.swift
//  TreeTableView
//
//  Created by Anton Lisovoy on 22/07/2019.
//  Copyright © 2019 Anton Lisovoy. All rights reserved.
//

import UIKit

public protocol TreeTableViewDataSource: class {
  func configureNodes() -> [Node]
}
