# ScrollViewController

![Platform](https://img.shields.io/badge/platform-iOS-333333.svg)
![Swift v5.0](https://img.shields.io/badge/swift-v5.0-orange.svg)
![test coverage 97%](https://img.shields.io/badge/test_covergage-97%25-success.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/ScrollViewController.svg)](https://cocoapods.org/pods/ScrollViewController)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Wraps your custom view and presents it on the screen in the way it fills visible area (not covered by navigation bar, keyboard etc.). If your custom view is too big, you will be able to scroll the content thanks to embedded `UIScrollView`.

![ScrollViewController Demo App](Misc/ScrollViewController_DemoApp.gif)

Starting from version `v1.1.0`, ScrollViewController does no longer depends on [KeyboardFrameChangeListener](https://github.com/darrarski/KeyboardFrameChangeListener) and [ScrollViewKeyboardAvoider](https://github.com/darrarski/ScrollViewKeyboardAvoider) frameworks, which makes it more portable and easier to integrate. That change also makes those frameworks obsolete.

`KeyboardFrameChangeListener` is used to observe keyboard frame changes and then
adjust insets using `ScrollViewKeyboardAvoider` so the keyboard does not cover the content. Supports "safe area layout" and makes the content fill visible area.

Designed to work on iPhone (including iPhone X) in portrait orientation (should also support other screen orientations as well as iPad screen).

## Install

Minimum deployment target: **iOS 10.0** (on **iOS >= 11** uses Safe Area Layout for iPhone X compatibility). 

Last version developed using Swift 4.2 is `v1.0.12`.

### CocoaPods

You can integrate `ScrollViewController` with your project using [CocoaPods](https://cocoapods.org). Just add this line to your `Podfile`:

```ruby
pod 'ScrollViewController', '~> 1.1'
```

### Carthage

You can also use [Carthage](https://github.com/Carthage/Carthage) if you prefer by adding following line to your `Cartfile`:

```
github "darrarski/ScrollViewController" ~> 1.1
```

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

- [Xcode](https://developer.apple.com/xcode/) v12.2
- [Ruby](https://www.ruby-lang.org/) with [Bundler](https://bundler.io/pl)

To bootstrap the project run:

```sh
bundle install
bundle exec fastlane setup
```

Then open `ScrollViewController.xcodeproj` in Xcode.

Use `DemoApp` build scheme for building and runing demo app.

Use `Tests` build scheme for runing tests.

To run tests from command line execute:

```sh
bundle exec fastlane test
```

To generate test coverage report in HTML format, run:

```sh
bundle exec fastlane coverage_html
```

Report will be saved in `coverage_report` directory.


## License

Copyright © 2019 Dariusz Rybicki Darrarski

[MIT License](LICENSE)
