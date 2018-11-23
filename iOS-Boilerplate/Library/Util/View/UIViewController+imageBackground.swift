//
//  UIViewController+imageBackground.swift
//  OSFramework
//
//  Created by Daniel Vela on 27/04/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setAppBackground(imageName: String) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: imageName)
        view.insertSubview(backgroundImage, at: 0)
    }
}

extension UITableViewController {
    func setAppBackgroundInTable(imageName: String) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: imageName)
        self.tableView.backgroundView = backgroundImage
    }
}
