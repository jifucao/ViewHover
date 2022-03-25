# ViewHover

[![CI Status](https://img.shields.io/travis/Jifu/ViewHover.svg?style=flat)](https://travis-ci.org/Jifu/ViewHover)
[![Version](https://img.shields.io/cocoapods/v/ViewHover.svg?style=flat)](https://cocoapods.org/pods/ViewHover)
[![License](https://img.shields.io/cocoapods/l/ViewHover.svg?style=flat)](https://cocoapods.org/pods/ViewHover)
[![Platform](https://img.shields.io/cocoapods/p/ViewHover.svg?style=flat)](https://cocoapods.org/pods/ViewHover)

## Usage

```swift
  /// add view hover effects
  hoverView.hoverEffects(.background(color: .red), .cornerRadius(10))

  /// add hover event listenner
  hoverView.onHover { hover in
      if hover {
          print("mouse hover on view: \(hover)")
      } else {
          print("mouse hover on view: \(hover)")
      }
  } 
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ViewHover is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ViewHover'
```

## License

ViewHover is available under the MIT license. See the LICENSE file for more info.
