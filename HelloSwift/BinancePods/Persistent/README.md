# Persistent

[![Platform](https://img.shields.io/badge/Platform-ios-lightgrey)](https://git.toolsfdg.net/fe/Persistent)
[![Language](https://img.shields.io/badge/language-Swift%205.1-orange.svg)](https://swift.org)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Persistent is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Persistent'
```

## Lint

```bash
pod lib lint --allow-warnings --sources='https://github.com/CocoaPods/Specs.git,https://git.toolsfdg.net/fe/BNCSpecs.git'
```


## Publish

```bash
pod repo push BNCSpecs --allow-warnings --verbose --sources='https://git.toolsfdg.net/fe/BNCSpecs.git,https://github.com/CocoaPods/Specs.git'
```

If you never add BNCSpecs:

```bash
pod repo add BNCSpecs https://git.toolsfdg.net/fe/BNCSpecs.git
```

## Author

Binance iOS Team.

## License

All rights reserved.

## FYI

If you want create a new library, please use this:

```bash
pod lib create {Your_Pod_Name} --template-url=https://git.toolsfdg.net/fe/binance-pod-template.git
```

