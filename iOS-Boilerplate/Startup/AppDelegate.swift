//
//  AppDelegate.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 21/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import AlamofireNetworkActivityIndicator
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
        return shared.internalDatabase
    }

    lazy var internalDatabase: CoreDataStack = {
        CoreDataStack(modelName: "iOS_Boilerplate")
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        enableNetworkIndicator()
        configureAppearance()
        #if DEBUG
        condifgureFLEXLauncher()
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

    private func enableNetworkIndicator() {
        NetworkActivityIndicatorManager.shared.isEnabled = true
        // To show the network indicator only when the response is very slow
        NetworkActivityIndicatorManager.shared.startDelay = 1.0
        // To avoid eliminating the indicator to fast
        NetworkActivityIndicatorManager.shared.completionDelay = 0.2
    }

    // MARK: - FLEX

    private func condifgureFLEXLauncher() {
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
