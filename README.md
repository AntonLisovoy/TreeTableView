# TreeTableView
[![Version](https://img.shields.io/cocoapods/v/TreeTableView.svg?style=flat)](http://cocoapods.org/pods/TreeTableView)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/AntonLisovoy/TreeTableView/blob/master/LICENSE.md)
[![Platform](https://img.shields.io/cocoapods/p/TreeTableView.svg?style=flat)](http://cocoapods.org/pods/TreeTableView)
[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
![iOS 9.0+](https://img.shields.io/badge/iOS-9.0%2B-blue.svg)

## Intoduction
Easiest usage of expandable & collapsible cell for iOS, written in Swift 5. Just provide `UITableViewCell` whatever you like and implement `TreeTableViewDataSource` and `TreeTableViewDelegate` protocols. `TreeTableView` is made because `insertRows` and `deleteRows` is hard to use.

![demo](Images/TreeTableView.gif)

## Usage
### Basic
```swift
import TreeTableView
```

Make `TreeTableView` in Storyboard or in code
```swift
@IBOutlet private weak var treeTableView: TreeTableView!
```

Inherit `TreeTableViewDataSource` and `TreeTableViewDelegate`
```swift
class ViewController: UIViewController, TreeTableViewDataSource, TreeTableViewDelegate
```

Set dataSource and delegate
```swift
treeTableView.treeDataSource = self
treeTableView.treeDelegate = self
```

Implement required `TreeTableViewDataSource` and `TreeTableViewDelegate` methods. See demo project for more information.

## Requirements
`TreeTableView` written in Swift 5.0. Compatible with iOS 9.0+

## Installation

### Cocoapods

TreeTableView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TreeTableView'
```
### Carthage
```
github "AntonLisovoy/TreeTableView"
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Author
[Anton Lisovoy](https://twitter.com/AntonLisovoy)

## License
TreeTableView is available under the MIT license. See the LICENSE.md file for more info.
