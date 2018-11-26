//
//  OSDNIValidator.swift
//  OSFramework
//
//  Created by Daniel Vela on 21/09/2016.
//  Copyright © 2016 Daniel Vela. All rights reserved.
//

import Foundation

/**
 Spanish DNI and NIE validator.
 It does not validate NIF.
*/
class OSDNIValidator: NSObject {

    /**
     Validate the correctness of a DNI number. Only DNI and NIE are validated,
     NIF behaviour is not tested.

     - Parameter dni: DNI to validate

     - Returns: **true** if valid
    */
    func isValid(dni: String) -> Bool {
        guard dni.count == 9 else {
            return false
        }

        var buffer = dni.uppercased()
        let range = buffer.makeRange(0..<1)
        buffer = buffer.replacingOccurrences(of: "X", with: "0", options: .caseInsensitive, range: range)
        buffer = buffer.replacingOccurrences(of: "Y", with: "1", options: .caseInsensitive, range: range)
        buffer = buffer.replacingOccurrences(of: "Z", with: "2", options: .caseInsensitive, range: range)

        let number = buffer[..<(buffer.index(buffer.endIndex, offsetBy: -1))]
        guard let baseNumber = Int(number) else {
            return false  // Is not a number
        }
        let letterMap = "TRWAGMYFPDXBNJZSQVHLCKET"
        let lettersIds = baseNumber % 23
        let expectedLetter = letterMap[lettersIds]
        let providedLetter = buffer[8]
        return expectedLetter == providedLetter
    }
}
