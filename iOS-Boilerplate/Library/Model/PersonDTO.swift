//
//  PersonDTO.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 21/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import Foundation

class PersonDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case name = "userName"
        case email
        case id = "serverId"
        case userId
    }

    var title: String
    var name: String
    var email: String
    var id: Int?
    var userId: Int

    init(title: String = "",
         name: String = "",
         email: String = "",
         userId: Int = 0,
         id: Int? = nil) {
        self.title = title
        self.name = name
        self.email = email
        self.userId = userId
        self.id = id
    }

    static func decode(jsonData: Data) -> PersonDTO? {
        let decoder = JSONDecoder()
        do {
            let person = try decoder.decode(PersonDTO.self, from: jsonData)
            return person
        } catch {
            print("error trying to convert json Data to PersonDTO object")
            print(error)
        }
        return nil
    }

    func encode() -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
            print("error trying to convert PersonDTO object to json Data")
            print(error)
        }
        return nil
    }
}
