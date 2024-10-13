# LoggableKit

[![CI Status](https://img.shields.io/travis/CocoaZhou/LoggableKit.svg?style=flat)](https://travis-ci.org/CocoaZhou/LoggableKit)
[![Version](https://img.shields.io/cocoapods/v/LoggableKit.svg?style=flat)](https://cocoapods.org/pods/LoggableKit)
[![License](https://img.shields.io/cocoapods/l/LoggableKit.svg?style=flat)](https://cocoapods.org/pods/LoggableKit)
[![Platform](https://img.shields.io/cocoapods/p/LoggableKit.svg?style=flat)](https://cocoapods.org/pods/LoggableKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LoggableKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LoggableKit'
```

## Usage
To configure console output filter, just set filtering option, and switch it back when needed.

```
BinanceLog.logFilter = .none
// Do something
BinanceLog.logFilter = .all
```

BinanceLogFilter is a Enum with Associated type

```
enum BinanceLogFilter {
    case all
    case none
    case including(categories: [BinanceLog.Category])
    case excluding(categories: [BinanceLog.Category])
}
```

Also there are several predefined filters, like

```
.onlyNetworking, .hideNetwoking, .onlyUI, .hideUI
```

To add custom filters, you can use that approach

```
extension BinanceLogFilter {
    static var onlyUsaNetworking = BinanceLogFilter.including(categories: (networkingCategories + usaNetworking).map { BinanceLog.Category($0) })
    static var usaNetworking = ["Donald Trump", "Barack Obama", "George Bush"]
}
```
    
NB: Run Test project to see how it works.

## Lint

```bash
pod lib lint --allow-warnings --sources='https://github.com/CocoaPods/Specs.git,https://git.toolsfdg.net/fe/BNCSpecs.git'
```


## Publish

```bash
pod repo push BNCSpecs --allow-warnings --verbose --sources='https://github.com/CocoaPods/Specs.git,https://git.toolsfdg.net/fe/BNCSpecs.git'
```

If you never add  BNCSpecs

```bash
pod repo add BNCSpecs https://git.toolsfdg.net/fe/BNCSpecs.git
```

## Author

CocoaZhou, cocoa.zhou@binance.com

## License

All rights reserved.
