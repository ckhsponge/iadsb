# iADSB

[![CI Status](https://img.shields.io/travis/Christopher Hobbs/iADSB.svg?style=flat)](https://travis-ci.org/Christopher Hobbs/iADSB)
[![Version](https://img.shields.io/cocoapods/v/iADSB.svg?style=flat)](https://cocoapods.org/pods/iADSB)
[![License](https://img.shields.io/cocoapods/l/iADSB.svg?style=flat)](https://cocoapods.org/pods/iADSB)
[![Platform](https://img.shields.io/cocoapods/p/iADSB.svg?style=flat)](https://cocoapods.org/pods/iADSB)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

iADSB is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'iADSB'
```

## Author

Christopher Hobbs, purposemc@gmail.com

## License

iADSB is available under the MIT license. See the LICENSE file for more info.

## Info.plist Settings

Create a row in your Info.plist for "App Transport Security Settings". Add a child row to that fow for "Allow Arbitrary Loads" and set it to Yes.

Add prompt text for each of the below in your Info.plist e.g. "Let's find a nearby airport!":
Privacy - Location Always and When In Use Usage Description
Privacy - Location Always Usage Description
Privacy - Location Usage Description
Privacy - Location When In Use Usage Description
