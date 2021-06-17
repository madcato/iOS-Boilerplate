//
//  NSDate+JSON.swift
//  happic-ios
//
//  Created by Daniel Vela on 26/04/16.
//  Copyright © 2016 Daniel Vela. All rights reserved.
//

import Foundation

extension Date {
    func toJSON() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormat.string(from: self)
    }

    static func fromJSON(_ dateStr: String) -> Date? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormat.date(from: dateStr)
    }

    func secondsFrom(_ date: Date) -> Int? {
        (Calendar.current as NSCalendar).components(NSCalendar.Unit.second,
                                                    from: date,
                                                    to: self,
                                                    options: []).second
    }
}
