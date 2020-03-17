//
//  Array.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 17/03/2020.
//  Copyright © 2020 veladan. All rights reserved.
//

extension Array {
    /**
        Insert an element at a position ordered.
        Precondition: the array must be already sorted.
        - parameter element: element to insert
        - parameter orderedBy: This block must return $0 < $1
     */
    mutating func insert(ordered element: Element, orderedBy: (_ A: Element, _ B: Element) -> Bool) {
        var low = 0
        var high = self.count - 1
        while low <= high {
            let mid = (low + high) / 2
            if orderedBy(self[mid], element) {
                low = mid + 1
            } else if orderedBy(element, self[mid]) {
                high = mid - 1
            } else {
                self.insert(element, at: mid)
                return
            }
        }
        self.insert(element, at: low)
    }
}
