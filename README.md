# iOS Boilerplate

This project includes some basic source codes, configurations and external integrations to start a basic iOS project

## Features included

### Files

- README.md (this file)
- CHANGELOG [How to keep a CHANGELOG](https://keepachangelog.com/en/0.3.0/)
- CONTRIBUTING.md (sample file from **Ruby On Rails**)
- LICENSE (initially MIT license)
- .gitignore (created with http://www.gitignore.io)

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
│   │   └───Model               // Persisted data model
│   │   └───Feed
│   │   └───Services
│   │   └───Extensions
│   │
│   └───Resources               // Resource files, like images, grouped by type
│   │   │   Images.xcassets     // Keep all images in one asset to help searches
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

- [Swift 4 json parsing and creating](https://grokswift.com/json-swift-4/)
- Load plist project files
- Web Service 
- Multi environment configurations
- Multi language
- Testing, Mocks, UI testing 
- Core Data
- Basic utils
- Theme classes (in order to make easy to control the colors of the app using UIAppearance class)

### Integrations

- [fastlane](https://fastlane.tools)
- [CI/CD with giltlab](https://docs.gitlab.com/ee/ci/yaml/)
- [sonarqube](https://www.sonarqube.org)
- [Swiftlint](https://github.com/realm/SwiftLint)
- [Dangerfile](https://github.com/danger/swift) llok https://github.com/realm/SwiftLint/blob/master/Dangerfile
- ??? RubyOnRails subproject to test remote API

## Project wiki

- [Swift style guide](wiki)

## Howto install

// TODO: explain how to install this project from zero.

