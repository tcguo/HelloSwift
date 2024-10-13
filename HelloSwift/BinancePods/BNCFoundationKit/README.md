# BNCFoundationKit

[![Version](https://img.shields.io/cocoapods/v/BNCFoundationKit.svg?style=flat)](https://cocoapods.org/pods/BNCFoundationKit)
[![License](https://img.shields.io/cocoapods/l/BNCFoundationKit.svg?style=flat)](https://cocoapods.org/pods/BNCFoundationKit)
[![Platform](https://img.shields.io/cocoapods/p/BNCFoundationKit.svg?style=flat)](https://cocoapods.org/pods/BNCFoundationKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

BNCFoundationKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

Source

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://git.toolsfdg.net/fe/BNCSpecs.git'
```
Target

```ruby
pod 'BNCFoundationKit'
```

## Lint

```bash
pod lib lint --allow-warnings --sources='https://github.com/CocoaPods/Specs.git,https://git.toolsfdg.net/fe/BNCSpecs.git' --verbose
```


## Publish

First time should add repo to local

```bash
pod repo add BNCSpecs https://git.toolsfdg.net/fe/BNCSpecs.git
```

Then

```bash
pod repo push BNCSpecs BNCFoundationKit.podspec --sources='https://github.com/CocoaPods/Specs.git,https://git.toolsfdg.net/fe/BNCSpecs.git' --allow-warnings --verbose
```

## Author

CocoaZhou, cocoa.zhou@binance.com

## License

BNCFoundationKit is available under the MIT license. See the LICENSE file for more info.
