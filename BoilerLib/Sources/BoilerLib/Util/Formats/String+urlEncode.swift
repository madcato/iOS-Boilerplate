//
//  String+urlEncode.swift
//  OSFramework
//
//  Created by Daniel Vela on 31/01/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

// scheme:[//[user[:password]@]host[:port]][/path][?query][#fragment]
enum URLPiece {
    case user
    case password
    case host
    case path
    case query
    case fragment
}

extension String {
    func encodeUrl(piece: URLPiece) -> String? {
        var characterSet: CharacterSet
        switch piece {
        case .user:
            characterSet = NSCharacterSet.urlUserAllowed
        case .password:
            characterSet = NSCharacterSet.urlPasswordAllowed
        case .host:
            characterSet = NSCharacterSet.urlHostAllowed
        case .path:
            characterSet = NSCharacterSet.urlPathAllowed
        case .query:
            characterSet = NSCharacterSet.urlQueryAllowed
        case .fragment:
            characterSet = NSCharacterSet.urlFragmentAllowed
        }
        return self.addingPercentEncoding(withAllowedCharacters: characterSet)
    }

    func decodeUrl() -> String? {
        self.removingPercentEncoding
    }
}
