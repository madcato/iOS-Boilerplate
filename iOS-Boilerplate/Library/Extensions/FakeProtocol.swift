//
//  FakeProtocol.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 29/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

/// This protocol is only used to show how Sourcery works
protocol FakeProtocol: AutoMockable {
    func run()
    func show(result: String)
}

/// Gender type
public enum Gender {
    case man
    case woman
}

public struct Person: AutoEquatable {
    public let name: String
    public let age: Int
    public let gender: Gender

    public init(name: String, age: Int, gender: Gender) {
        self.name = name
        self.age = age
        self.gender = gender
    }
}
