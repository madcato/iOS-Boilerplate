//
//  AppDelegate.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 21/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import CoreData
#if DEBUG
import FLEX
#endif
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    static var shared: AppDelegate {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            return delegate
        }
        assert(false)
        return AppDelegate()
    }

    static var database: CoreDataStack {
        shared.internalDatabase
    }

    lazy var internalDatabase: CoreDataStack = {
        CoreDataStack(modelName: "iOS_Boilerplate")
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureAppearance()
        #if DEBUG
        configureFLEXLauncher()
        #endif
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        internalDatabase.saveContext()
    }

    // MARK: - FLEX

    private func configureFLEXLauncher() {
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(AppDelegate.launchFLEX))
        recognizer.minimumPressDuration = 4.0
        recognizer.numberOfTapsRequired = 0
        recognizer.numberOfTouchesRequired = 2  // Use two fingers
        self.window?.addGestureRecognizer(recognizer)
    }

    @objc
    private func launchFLEX() {
        FLEXManager.shared().showExplorer()
    }
}
