//
//  System.swift
//  Library
//
//  Created by Daniel Vela on 08/08/16.
//  Copyright © 2016 veladan. All rights reserved.
//

import UIKit

enum System {
    // When the mobile detects something near the display, turn off it
    static func enableProximitySensor() {
        UIDevice.current.isProximityMonitoringEnabled = true
    }
    // Disable proximity sensor
    static func disableProximitySensor() {
        UIDevice.current.isProximityMonitoringEnabled = false
    }

    static func radians(degrees: Double) -> Double {
        degrees * Double.pi / 180
    }

    static func getDateFormatCurrentLocale(dateComponents: String) -> String? {
        let locale = NSLocale.current
        let dateFormat = DateFormatter.dateFormat(fromTemplate: dateComponents,
                                                  options: 0,
                                                  locale: locale)
        return dateFormat
    }

    static func disableIdleTimer() {
        UIApplication.shared.isIdleTimerDisabled = true
    }

    static func loadDictionaryFromResource(fileName: String) -> NSMutableDictionary? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist") else {
            return nil
        }
        let plist = NSMutableDictionary(contentsOfFile: path)
        return plist
    }

    static func loadArrayFromResource(fileName: String) -> NSMutableArray? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist") else {
            return nil
        }
        let plist = NSMutableArray(contentsOfFile: path)
        return plist
    }

    static func redrawView(view: UIView) {
        view.setNeedsDisplay()
    }

    static func existObjectInConfiguration(_ objectName: String) -> Bool {
        guard UserDefaults.standard.object(forKey: objectName) != nil else {
            return false
        }
        return true
    }

    static func createObjectInConfiguration(_ object: Any?, forKey objectName: String) {
        UserDefaults.standard.set(object, forKey: objectName)
        UserDefaults.standard.synchronize()
    }

    static func loadFromConfig(_ objectName: String) -> Any? {
        UserDefaults.standard.object(forKey: objectName)
    }

    static func getPreferredLanguage() -> String? {
        NSLocale.current.languageCode
    }

    static func getLocaleIdentifier() -> String {
        Locale.current.identifier
    }

    static func batteryLevel() -> Float {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        let level = device.batteryLevel
        device.isBatteryMonitoringEnabled = false
        return level
    }

    static func screenBright() -> CGFloat {
        UIScreen.main.brightness
    }

    static func setScreenBright(_ bright: CGFloat) {
        UIScreen.main.brightness = bright
    }

    static func registerUserDefaults() {
        guard let settingsBundle = Bundle.main.path(forResource: "Settings",
                                                    ofType: "bundle") else {
            NSLog("Could not find Settings.bundle")
            return
        }
        guard let settings = NSDictionary(contentsOfFile: settingsBundle.appending("Root.plist")) else {
            NSLog("Could not load Root.plist")
            return
        }
        if let preferences = settings["PreferenceSpecifiers"] as? NSArray {
            let defaultsToRegister: [String: Any] = collectProperties(preferences)
            UserDefaults.standard.register(defaults: defaultsToRegister)
        }
    }

    static func collectProperties(_ preferences: NSArray) -> [String: Any] {
    var defaultsToRegister: [String: Any] = [:]
        for case let prefSpecification as NSDictionary in preferences {
            if let key = prefSpecification["Key"] as? String {
                if let object = UserDefaults.standard.object(forKey: key) {
                    defaultsToRegister[key] = object
                }
            }
        }
        return defaultsToRegister
    }

    static func generateUUID() -> String {
        let uuid = NSUUID()
        let uuidStr = uuid.uuidString
        return uuidStr
    }
}
