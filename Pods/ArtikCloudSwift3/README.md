# ARTIK Cloud Swift3 SDK
![Supported Version](https://img.shields.io/badge/Swift-3-green.svg)
![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)
![CocoaPods](https://img.shields.io/badge/CocoaPods-1.1-green.svg)

This SDK helps you connect your iOS, OS X, tvOS, and watchOS applications to ARTIK Cloud. It exposes a number of methods to easily execute REST API calls to ARTIK Cloud.

## Requirements

The Swift3 SDK requires [CocoaPods 1.1+](https://guides.cocoapods.org/using/getting-started.html) to be installed. 

## Installation

To install it, specify `ArtikCloudSwift3` in your `PodFile`:

```ruby
use_frameworks!
pod 'ArtikCloudSwift3', :git => 'https://github.com/artikcloud/artikcloud-swift3.git', :branch => 'pvm-changes'
```

Then run the following command:
```
pod install
```

## Coding Recommendation

It's recommended to create an instance of ApiClient per thread in a multithreaded environment to avoid any potential issue.

Usage
------

Peek into the Tests for examples about how to use the SDK.

In addition, you can look at our tutorial and sample applications. These will give you a good overview of what you can do and how to do it.

More about ARTIK Cloud
---------------------

If you are not familiar with ARTIK Cloud, we have extensive documentation at https://developer.artik.cloud/documentation

The full ARTIK Cloud API specification can be found at https://developer.artik.cloud/documentation/api-reference/

Check out advanced sample applications at https://developer.artik.cloud/documentation/samples/

To create and manage your services and devices on ARTIK Cloud, create an account at https://developer.artik.cloud

Also see the ARTIK Cloud blog for tutorials, updates, and more: http://artik.io/blog/cloud

Licence and Copyright
---------------------

Licensed under the Apache License. See [LICENSE](https://github.com/artikcloud/artikcloud-swift/blob/master/LICENSE).

Copyright (c) 2016 Samsung Electronics Co., Ltd.
