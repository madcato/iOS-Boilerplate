[![pipeline status](https://gitlab.veladan.org/veladan/ios-boilerplate/badges/master/pipeline.svg)](https://gitlab.veladan.org/veladan/ios-boilerplate/commits/master)
[![coverage report](https://gitlab.veladan.org/veladan/ios-boilerplate/badges/master/coverage.svg)](https://gitlab.veladan.org/veladan/ios-boilerplate/commits/master)
[![codebeat badge](https://codebeat.co/badges/64742c1a-a4de-454c-840f-824a75904ddf)](https://codebeat.co/projects/github-com-madcato-ios-boilerplate-master)

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

Included in the project directly using [Carthage](https://github.com/Carthage/Carthage). This way is easier to manage versions of this external frameworks. Carthage does not add much build time, because it builds the frameworks previously and add them to the repository.

- [Alamofire](https://github.com/Alamofire/Alamofire)
  For accesing remote http servers
- [SDWebImage](https://github.com/SDWebImage/SDWebImage)
  To download and show images asyncronously
- [Mansonry](https://github.com/SnapKit/Masonry)
  To use Constraints from code without becoming insane
- [Nimble](https://github.com/Quick/Nimble)
  To define expectations for automated testing
- [Quick](https://github.com/Quick/Quick)
  BDD for Swift
- [AlamofireNetworkActivityIndicator](https://github.com/Alamofire/AlamofireNetworkActivityIndicator)
  To manage the network activity indicator automatically with Alamofire
- [AlamofireImage](https://github.com/Alamofire/AlamofireImage)
  AlamofireImage is an image component library for Alamofire
- [FLEX](https://github.com/Flipboard/FLEX
  Debugging helper. (Press the screen during 4 seconds with two fingers to launch helper)
- [Sqlite.swift](https://github.com/stephencelis/SQLite.swift)
  A type-safe, Swift-language layer over SQLite3
  [Sqlite.swift usage manual](https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#manual)
- [SQLiteMigrationmanager.swift](https://github.com/garriguv/SQLiteMigrationManager.swift)
  Migration manager for SQLite.swift

#### Carthage version setting

[Read about Semver](http://semver.org/) to know the meaning of each component in the version code string: a.b.c

\>= 1.0 for “at least version 1.0”       
~> 1.0 for “compatible with version 1.0”    
== 1.0 for “exactly version 1.0”    

### Sample codes

- [Swift 4 json parsing and creating](https://grokswift.com/json-swift-4/) _(See class Library/Model/PersonDTO.swift)_
- Multi environment configurations [Using Xcode Configuration (.xcconfig) to Manage Different Build Settings](https://appcoda.com/xcconfig-guide/)
- Multi language
- Web Service 
- Testing, Mocks, UI testing 
- Core Data
- Basic utils
- Theme classes (in order to make easy to control the colors of the app using UIAppearance class)
- Login made with [Clean-Swift architecture](https://clean-swift.com/)

### Integrations

- [fastlane](https://fastlane.tools)
  To manage the build of the project and publish the app into TestFlight and App Store
- [CI/CD with giltlab](https://docs.gitlab.com/ee/ci/yaml/)
  To create automated jobs for building, analyze code and publications
- [Swiftlint](https://github.com/realm/SwiftLint)
  To analyze statically code quality

#### Furture integrations

- [Dangerfile](https://github.com/danger/swift)
  To add automated customized rules to the process of Pull Request.
- [FormatterKit](https://github.com/mattt/FormatterKit)
  ```stringWithFormat:``` for the sophisticated hacker set
- [Crashlytics/Fabric](https://fabric.io/kits/ios/crashlytics/manual-install)
- [Turbolinks](https://github.com/turbolinks/turbolinks-ios)
  Mix web view controllers and native controllers to create hibrids apps without the hell of angular.js  

## Project wiki

- [Swift style guide](wiki) Mantain in your wiki the conventions used by your team
  [Use Linkeding swift style guide](https://github.com/linkedin/swift-style-guide)

## HowTo install

### Requirements

* Xcode 9+
* iOS 10+
* brew
* fastlane
* sourcery
* swiftlint

### Getting the source

First, check out the source, including all the dependencies:

    $ git clone --recurse-submodules https://github.com/madcato/iOS-Boilerplate

### Installing other dependencies

#### [Brew](https://brew.sh)

    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#### [Fastlane](https://docs.fastlane.tools/getting-started/ios/setup/)

    $ xcode-select --install
    $ brew cask install fastlane

#### [Sourcery](https://github.com/krzysztofzablocki/Sourcery)

    $ brew install sourcery

#### [SwiftLint](https://github.com/realm/SwiftLint)

    $ brew install swiftlint

### Building it

Open the project, iOS-Boilerplate.xcodeproj, and build and run.

### Build with fastlane

    $  bundle exec fastlane build

The computer where fastlane is going to run must have the provissioning and private key installed

### Send app to TestFlight with fastlane

    $  bundle exec fastlane beta

The computer where fastlane is going to run must have the provissioning and private key installed

### Launch tests with fastlane

    $  bundle exec fastlane tests


## Recommended links

- https://medium.com/cocoaacademymag/unit-testing-network-request-3a75061fcf4c
- https://kean.github.io/post/api-client
- https://clean-swift.com/clean-swift-ios-architecture/

## Migration guide for SQLite.swift

1. Create a migration file in ```Migration.bundle```:
      $ touch "`ruby -e "puts Time.now.strftime('%Y%m%d%H%M%S').to_i"`"_name.sql
2. Add the sql command text to that file.

If the migration must be made with swift code:

1. Create a new class inheriting from ```Migration``` class:

        struct NewSeedDB: Migration {
          var version: Int64 = 20_160_119_131_206_685
          func migrateDatabase(_ db: Connection) throws {  // swiftlint:disable:this identifier_name
            let episodes = Table("episodes")
            let season = Expression<Int>("season")
            let name = Expression<String>("name")
            try (1...24).map { "Episode \($0)" }.forEach {
                _ = try db.run(episodes.insert(season <- 1, name <- $0))
            }
          }
        }

  1. Set in ```version``` property the year, month, day, hour, minutos, seconds ('%Y%m%d%H%M%S') in order to allow migration manager to know the order to sort the migrations.
  2. Implement method ```migrateDatabase``` with the changes.
2. Add the new struct/class name to the migration array (look for property variabla named **migration** in class *SQLiteDBMigrations*

## Implementation sample with Clean-Swift Architecture

In the group ```iOS-Boilerplate/Login``` you can find the sample files implementing a login functionality using an [architecture named Clean-Swift](https://clean-swift.com/clean-swift-ios-architecture/):

Files:

- LoginViewController: view controller that manages the login view.
- LoginModels: Structs to move data between view controller, interactor and presenter
- LoginInteractor: This class is used from the view controller in order to run the operations launched by the user interacting with the UI. Also manages any other requirement from the view controller.
- LoginPresenter: This class adapts the data to the final data types that will be showed in the view. Transformations like Date to String and texts translations are made by this class.
- LoginRouter: This class manages the view transitions.
- LoginWorker: This class implements the functionality.

## Antoher implementation sample with Clean-Swift Architecture

Int the group ```Github``` there is a coomplete table view controller and detail view controlles for showing Github event.