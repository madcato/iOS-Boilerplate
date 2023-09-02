//
//  Codable.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 05/12/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import Foundation

public extension Decodable {
    /// Decode this object from a json from a Data object
    static func decode<T: Decodable>(object jsonData: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(T.self, from: jsonData)
            return decoded
        } catch {
            print("error trying to convert json Data to \(String(describing: T.self)) object")
            print(error)
        }
        return nil
    }

    /// Decode an arroy of objects from a json from a Data object
    static func decode<T: Decodable>(array jsonData: Data) -> [T]? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode([T].self, from: jsonData)
            return decoded
        } catch {
            print("error trying to convert json Data to \(String(describing: [T].self)) object")
            print(error)
            #if DEBUG
                fatalError("Unresolved error \(error)")
            #endif
        }
    }
}

public extension Encodable {
    /// Encode this object into a Data object of type json
    static func encode<T: Encodable>(object: T) -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            return data
        } catch {
            print("error trying to convert \(String(describing: T.self)) object to json Data")
            print(error)
        }
        return nil
    }

    /// Encode this object into a Data object of type json
    static func encode<T: Encodable>(array: [T]) -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(array)
            return data
        } catch {
            print("error trying to convert \(String(describing: [T].self)) object to json Data")
            print(error)
        }
        return nil
    }
}
