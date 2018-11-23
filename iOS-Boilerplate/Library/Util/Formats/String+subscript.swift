//
//  String+subscript.swift
//  happic-ios
//
//  Created by Daniel Vela on 29/04/16.
//  Copyright © 2016 Daniel Vela. All rights reserved.
//

import Foundation

extension String {
    var length: Int {
        return self.count
    }

    subscript(integerIndex: Int) -> Character {
        let index = self.index(startIndex, offsetBy: integerIndex)
        return self[index]
    }

    subscript(integerRange: Range<Int>) -> String {
        let start = self.index(startIndex, offsetBy: integerRange.lowerBound)
        let end = self.index(startIndex, offsetBy: integerRange.upperBound)
        let range = start..<end
        return String(self[range])
    }

    func makeRange(_ integerRange: Range<Int>) -> Range<String.Index> {
        let start = self.index(startIndex, offsetBy: integerRange.lowerBound)
        let end = self.index(startIndex, offsetBy: integerRange.upperBound)
        return start..<end
    }
}
