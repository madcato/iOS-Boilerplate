//
//  CoreDataStackEntity.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 15/8/23.
//  Copyright © 2023 veladan. All rights reserved.
//

import CoreData

public protocol CoreDataStackEntity {
    associatedtype TypeEntity
}

public extension CoreDataStackEntity {
    static func all(from database: CoreDataStack) -> [TypeEntity]? {
        database.getObjects(ofType: String(describing: TypeEntity.self)) as? [TypeEntity]
    }

    static func allSortedByName(from database: CoreDataStack) -> [TypeEntity]? {
        database.getObjects(ofType: String(describing: TypeEntity.self), SortBy("name")) as? [TypeEntity]
    }

    static func getObject(by id: NSManagedObjectID, in database: CoreDataStack) -> TypeEntity? {
        database.getObject(byId: id) as? TypeEntity
    }

    static func getObject(by fieldName: String, equalTo value: Any, in database: CoreDataStack) -> TypeEntity? {
        database.getObject(ofType: String(describing: TypeEntity.self),
                           Where(predicate: "\(fieldName) == \(value)")) as? TypeEntity
    }

    static func create(in database: CoreDataStack) -> TypeEntity? {
        database.createObject(entityName: String(describing: TypeEntity.self)) as? TypeEntity
    }

    static func count(in database: CoreDataStack) -> Int {
        database.count(String(describing: TypeEntity.self))
    }
}
