# iOS Boilerplate

This project includes some basic source codes, configurations and external integrations to start a basic iOS project

## Features included

### Files

- README.md (this file)
- CHANGELOG [How to keep a CHANGELOG](https://keepachangelog.com/en/0.3.0/)
- CONTRIBUTING.md (sample file from **Ruby On Rails**)
- LICENSE (initially MIT license)
- .gitignore (created with [gitignore.io](http://www.gitignore.io))

### Configuration

- Basic project directory estructure

```
Project
│
└───iOS-Boilerplate
│   │
│   └───Startup                // App start related classes, like Migrations
│   │   │   AppDelegate.swift
│   │   │
│   │   └───Migration          // Classes and models for persisted data migrations
│   │                          //  between versions
│   │
│   └───Feature001             // Classes, resources, storyboards related to only one feature
│   │   │   Feature001Model.swift
│   │   │   Feature001UI.storyboard
│   │   │   Feature001ViewController.swift
│   │   │
│   │   └───Cells
│   │
│   └───Feature002
│   │
│   └───Feature003
│   │
│   └───Feature004
│   │
│   └───ComplexFeature001
│   │   │
│   │   └───Subfeature002
│   │   │
│   │   └───Subfeature003
│   │
│   └───Library                 // keep in this group all shared code between features
│   │   │
│   │   └───Configuration       // Classes with the app configuration, like serverURL 
│   │   └───Model               // Persisted data model
│   │   └───Feed
│   │   └───Services
│   │   └───Extensions
│   │
│   └───Resources               // Resource files, like images, grouped by type
│   │   │   Images.xcassets     // Keep all images in one asset to help searches
│   │   │
│   │   └───environments        // Plist files with the configuration of each environment
│   │   │   |   integration.plist
│   │   │   |   production.plist
│   │   │   |   staging.plist
│   │   │
│   │   └───pdf
│   │   └───certificates
│   │   └───html
│   │   └───json
│   │   └───video
│   │   └───plist
│   │
│   └───Supporting Files
│       │   iOS-Boilerplate.entitlements
│       │   Info.plist
│       │   main.m
│
└───Frameworks                // External projects,libraries and frameworks
│    │
│    └───Alamofire.xcodeproj
│    └───CoreMotion.framework
│    │   libz.dylib
│    │   libarichive.framework
│    │
│    └───Security.framework
│
└───iOS-BoilerplateTests
│
└───iOS-BoilerplateUITests
│
└───Products
```

### External frameworks

Included in the project directly using [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules). It's better not to use Carthage or Cocoapods.

- [Alamofire](https://github.com/Alamofire/Alamofire)

### Sample codes

- [Swift 4 json parsing and creating](https://grokswift.com/json-swift-4/) _(See class Library/Model/PersonDTO.swift)_
- Multi environment configurations [Using Xcode Configuration (.xcconfig) to Manage Different Build Settings](https://appcoda.com/xcconfig-guide/)
- Multi language
- Web Service 
- Testing, Mocks, UI testing 
- Core Data
- Basic utils
- Theme classes (in order to make easy to control the colors of the app using UIAppearance class)

### Integrations

- [fastlane](https://fastlane.tools)
- [CI/CD with giltlab](https://docs.gitlab.com/ee/ci/yaml/)
- [Swiftlint](https://github.com/realm/SwiftLint)
- [Dangerfile](https://github.com/danger/swift) llok https://github.com/realm/SwiftLint/blob/master/Dangerfile
- ??? RubyOnRails subproject to test remote API

## Project wiki

- [Swift style guide](wiki) Mantain in your wiki the conventions used by your team
  [Use Linkeding swift style guide](https://github.com/linkedin/swift-style-guide)

## HowTo install

### Requirements

* Xcode 9+
* iOS 10+

### Getting the source

First, check out the source, including all the dependencies:

git clone --recurse-submodules https://github.com/madcato/iOS-Boilerplate

### Building it

Open the project, iOS-Boilerplate.xcodeproj, and build and run.

### Build with fastlane

    $  bundle exec fastlane beta

The computer where fastlane is going to run must have the provissioning and private key installed

### Launch tests with fastlane

    $  bundle exec fastlane tests
    
    

