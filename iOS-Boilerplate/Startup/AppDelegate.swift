//
//  AppDelegate.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 21/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import CoreData
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    static var shared: AppDelegate {
        assert(Thread.current.isMainThread == true)
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

    static var backgroundDatabase: CoreDataStack {
        shared.internalBackgroundDatabase
    }

    lazy var internalBackgroundDatabase: CoreDataStack = {
        CoreDataStack(backgroundWithMaster: internalDatabase)
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureAppearance()
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
}
