//
//  AppleUrlHelper.swift
//  OSFramework
//
//  Created by Daniel Vela on 30/04/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import UIKit

class UrlHelper {
    func launch(_ urlStr: String) {
        if let url = URL(string: urlStr) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            assertionFailure()
        }
    }
}

class MapUrlHelper: UrlHelper {
    func directionsTo(address: String) {
        if let scapedAddress = address.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            let url = "http://maps.apple.com/?daddr=\(scapedAddress)&dirflg=w&t=m"
            super.launch(url)
        }
    }

    func directionsTo(location: String) {
        if let scapedLocation = location.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            let url = "http://maps.apple.com/?daddr=\(scapedLocation)&dirflg=w&t=m"
            super.launch(url)
        }
    }
}
