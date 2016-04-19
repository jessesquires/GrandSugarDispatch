# GrandSugarDispatch
[![Build Status](https://secure.travis-ci.org/jessesquires/GrandSugarDispatch.svg)](http://travis-ci.org/jessesquires/GrandSugarDispatch) [![Version Status](https://img.shields.io/cocoapods/v/GrandSugarDispatch.svg)][podLink] [![license MIT](https://img.shields.io/cocoapods/l/GrandSugarDispatch.svg)][mitLink] [![codecov.io](https://img.shields.io/codecov/c/github/jessesquires/GrandSugarDispatch.svg)](http://codecov.io/github/jessesquires/GrandSugarDispatch) [![Platform](https://img.shields.io/cocoapods/p/GrandSugarDispatch.svg)][docsLink] [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

*Syntactic sugar for Grand Central Dispatch (GCD)*

## About

This library is a lightweight *Swifty* wrapper around GCD.

## Requirements

* Xcode 7.3+
* iOS 8.0+
* OSX 10.10+
* tvOS 9.1+
* watchOS 2.0+
* Swift 2.2+

## Installation

#### [CocoaPods](http://cocoapods.org) (recommended)

````ruby
use_frameworks!

# For latest release in cocoapods
pod 'GrandSugarDispatch'

# Feeling adventurous? Get the latest on develop
pod 'GrandSugarDispatch', :git => 'https://github.com/jessesquires/GrandSugarDispatch.git', :branch => 'develop'
````

#### [Carthage](https://github.com/Carthage/Carthage)

````bash
github "jessesquires/GrandSugarDispatch"
````

## Documentation

Read the [docs][docsLink]. Generated with [jazzy](https://github.com/realm/jazzy). Hosted by [GitHub Pages](https://pages.github.com). More information on the [`gh-pages`](https://github.com/jessesquires/GrandSugarDispatch/tree/gh-pages) branch.

## Getting Started

````swift
import GrandSugarDispatch
````

#### Example usage

```swift
dispatch(queue: .main) {
    // perform task asynchronously on main queue
}

dispatch(queue: .utility, concurrency: .sync) {
    // perform task *synchronously* on background utility (quality of service) queue
}

dispatch(queue: .background, concurrency: .delay(0.3)) {
    // perform task on background queue, after a 0.3 second delay
}
```

## Unit tests

There's a suite of unit tests for `GrandSugarDispatch.framework`. To run them, open `GrandSugarDispatch.xcodeproj`, select the `GrandSugarDispatchTests` scheme, then &#x2318;-U.

These tests are well commented and serve as further documentation for how to use this library.

## Contribute

Please follow these sweet [contribution guidelines](https://github.com/jessesquires/HowToContribute).

## Credits

Created and maintained by [**@jesse_squires**](https://twitter.com/jesse_squires).

## License

`GrandSugarDispatch` is released under an [MIT License][mitLink]. See `LICENSE` for details.

>**Copyright &copy; 2016-present Jesse Squires.**

*Please provide attribution, it is greatly appreciated.*

[podLink]:https://cocoapods.org/pods/GrandSugarDispatch
[docsLink]:http://www.jessesquires.com/GrandSugarDispatch
[mitLink]:http://opensource.org/licenses/MIT
