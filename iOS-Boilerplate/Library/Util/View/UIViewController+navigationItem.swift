//
//  UIViewController+navigationItem.swift
//  OSFramework
//
//  Created by Daniel Vela on 15/07/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import UIKit

extension UIViewController {
    func setRightBarButtonItem(_ item: UIBarButtonItem) {
        navigationController?.navigationBar.topItem?.rightBarButtonItem = item
    }
}
