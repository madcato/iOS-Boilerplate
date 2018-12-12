//
//  SqliteDBManager.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 12/12/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import Foundation
import SQLite

class SqliteDBManager {
    var db: Connection  // swiftlint:disable:this identifier_name

    init(database filename: String) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths.first ?? "."
        let finalDBPath = "\(documentsDirectory)/\(filename)"
        do {
            db = try Connection(finalDBPath)
        } catch {
            fatalError("Critical error opening sqlite db: \(finalDBPath)")
        }
        setLoggin()
    }

    init(testing: Bool) {
        guard testing == true else {
            fatalError("Call this method only for testing purposes")
        }
        do {
            db = try Connection(.temporary) // Use `let db = try Connection(.temporary)` to create in-memory databases
        } catch {
            fatalError("Critical error opening sqlite temporary db")
        }
        setLoggin()
    }

    func sampleQuery() throws {
        let id = Expression<Int64>("id")
        let email = Expression<String>("email")
        let name = Expression<String>("name")
        let users = Table("users")
        for user in try db.prepare(users) {
            print("id: \(user[id]), email: \(user[email]), name: \(user[name])")
            // id: 1, email: alice@mac.com, name: Optional("Alice")
        }
        // SELECT * FROM "users"
    }

    func insertRow() throws {
        let email = Expression<String>("email")
        let name = Expression<String>("name")
        let users = Table("users")

        try db.run(users.insert(email <- "dani@vela.me", name <- "Dani Vela"))
        // INSERT INTO "users" ("email", "name") VALUES ('dani@vela.me', 'Dani Vela')

        let rowid = try db.run(users.insert(or: .replace, email <- "dani@vela.me", name <- "Dani T. Vela"))
        // INSERT OR REPLACE INTO "users" ("email", "name") VALUES ('dani@vela.me', 'Dani T. Vela')
        print("Inserted or updated rowid: \(rowid)")
    }

    func catchingErrors() {
        let email = Expression<String>("email")
        let users = Table("users")
        do {
            try db.run(users.insert(email <- "dani@vela.me"))
            try db.run(users.insert(email <- "dani@vela.me"))
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("constraint failed: \(message), in \(String(describing: statement))")
        } catch {
            print("insertion failed: \(error)")
        }
    }

    func createTable() throws {
        let id = Expression<Int64>("id")
        let email = Expression<String>("email")
        let name = Expression<String>("name")
        let users = Table("users")

        try db.run(users.create { table in      // CREATE TABLE "users" {
            table.column(id, primaryKey: true)  //      "id" INTEGER PRIMARY KEY NOT NULL
            table.column(email, unique: true)   //      "email" TEXT UNIQUE NOT NULL
            table.column(name)                  //      "name" TEXT
        })                                      // }
    }

    private func setLoggin() {
#if DEBUG
        db.trace { print($0) }
#endif
    }
}
