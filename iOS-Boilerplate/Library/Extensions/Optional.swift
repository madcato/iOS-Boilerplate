//
//  Optional.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 17/03/2020.
//  Copyright © 2020 veladan. All rights reserved.
//

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}
