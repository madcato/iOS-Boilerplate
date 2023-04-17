//
//  AppDelegate+Theme.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 20/12/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import UIKit

extension AppDelegate {
    /// Main colors
    static var mainColor = UIColor(red: 0x8C / 0xFF, green: 0x8E / 0xFF, blue: 0x8F / 0xFF, alpha: 1.0)
    static var secondaryColor = UIColor(red: 0x1D / 0xFF, green: 0x1D / 0xFF, blue: 0x1D / 0xFF, alpha: 1.0)
    static var almostWhite = UIColor(red: 0.9, green: 0.9, blue: 1.0, alpha: 1.0)
    static var lightGray = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    static var darkMainColor = UIColor(red: 0x8C / 0xFF, green: 0x8E / 0xFF, blue: 0x8F / 0xFF, alpha: 1.0)
    static var darkBlueColor = UIColor(red: 0x10 / 0xFF, green: 0x10 / 0xFF, blue: 0xFF / 0xFF, alpha: 1.0)

    /// Main color styles
    static var navBarColor = secondaryColor
    static var navBarTextColor = darkBlueColor
    static var mainButtonColor = mainColor
    static var mainButtonTextColor = secondaryColor
    static var cancelButtonColor = lightGray
    static var cancelButtonTextColor = secondaryColor
    static var backgroundViewColor = mainColor
    static var mainLabelTextColor = mainColor
    static var mainLabelBackColor = lightGray
    static var simpleLabelTextColor = secondaryColor
    static var cellTextColor = secondaryColor

    /**
     Call this method from the **AppDelegate.application:didFinishLaunchingWithOptions** method in order to set the
     basic and initial appearance of the app. This styles can be modified by the view controllers, controls or views
     afterwards.

     Other examples of styling:
       ```
        UIApplication.sharedApplication().keyWindow!.tintColor = self.mainColor
        UIWindow.appearance().tintColor = self.mainColor
        UINavigationBar.appearance().tintColor = self.mainColor
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor = AppDelegate.cellTextColor
       ```
    */
    func configureAppearance() {
        UINavigationBar.appearance().barTintColor = AppDelegate.navBarColor
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: AppDelegate.navBarTextColor]
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: AppDelegate.navBarTextColor], for: UIControl.State())
        UIBarButtonItem.appearance().tintColor = AppDelegate.navBarTextColor
        UISwitch.appearance().onTintColor = AppDelegate.darkMainColor
    }
}
