# ScrollViewController

![Platform](https://img.shields.io/badge/platform-iOS-333333.svg)
![Swift v4.0](https://img.shields.io/badge/swift-v4.0-orange.svg)
![Code Coverage](https://img.shields.io/badge/coverage-97%25-green.svg)
[![Build Status](https://travis-ci.org/darrarski/ScrollViewController.svg?branch=master)](https://travis-ci.org/darrarski/ScrollViewController)
[![CocoaPods](https://img.shields.io/cocoapods/v/ScrollViewController.svg)](https://cocoapods.org/pods/ScrollViewController)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Wraps your custom view and presents it on the screen in the way it fills visible area (not covered by navigation bar, keyboard etc.). If your custom view is too big, you will be able to scroll the content thanks to embedded `UIScrollView`.

![ScrollViewController Demo App](Misc/ScrollViewController_DemoApp.gif)

Uses [KeyboardFrameChangeListener](https://github.com/darrarski/KeyboardFrameChangeListener) to observe keyboard frame changes and then
adjusts insets using [ScrollViewKeyboardAvoider](https://github.com/darrarski/ScrollViewKeyboardAvoider) so the keyboard does not cover the content. Supports "safe area layout" and makes the content fill visible area.

Designed to work on iPhone (including iPhone X) in portrait orientation (should also support other screen orientations as well as iPad screen).

## Install

Minimum deployment target: **iOS 10.0** (on **iOS 11** uses Safe Area Layout for iPhone X compatibility)

### CocoaPods

You can integrate `ScrollViewController` with your project using [CocoaPods](https://cocoapods.org). Just add this line to your `Podfile`:

```ruby
pod 'ScrollViewController', '~> 1.0'
```

### Carthage

You can also use [Carthage](https://github.com/Carthage/Carthage) if you prefer by adding following line to your `Cartfile`:

```
github "darrarski/ScrollViewController" ~> 1.0
```

`ScrollViewController` depends on [KeyboardFrameChangeListener](https://github.com/darrarski/KeyboardFrameChangeListener) and [ScrollViewKeyboardAvoider](https://github.com/darrarski/ScrollViewKeyboardAvoider). Dependencies will be automatically resolved by Carthage, but you will have to integrate dependent frameworks with your app as well. For more information refer to [Carthage docs](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

## Use

Example can be found in [DemoApp](DemoApp).

**TL;DR**

```swift
let yourContentView: UIView

let scrollViewController = ScrollViewController()
scrollViewController.contentView = yourContentView
```

## Develop

Requirements: 

- [Carthage](https://github.com/Carthage/Carthage)
- Ruby with [Bundler](http://bundler.io)
- Xcode 9

To bootstrap the project run:

```sh
bundle install
bundle exec fastlane setup
```

Then open `ScrollViewController.xcworkspace` in Xcode.

Use `DemoApp` build scheme for building and runing demo app.

Use `Tests` build scheme for runing tests.

To run tests from command line execute:

```sh
bundle exec fastlane test
```

## License

MIT License - check out [LICENSE](LICENSE) file.
