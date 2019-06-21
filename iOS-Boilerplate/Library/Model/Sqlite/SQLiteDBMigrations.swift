//
//  SQLiteDBMigrations.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 12/12/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import SQLite
//import SQLiteMigrationManager

enum SQLiteDBMigrations {
//    struct SeedDB: Migration {
//        var version: Int64 = 20_160_119_131_206_685
//
//        func migrateDatabase(_ db: Connection) throws {  // swiftlint:disable:this identifier_name
//            let episodes = Table("episodes")
//            let season = Expression<Int>("season")
//            let name = Expression<String>("name")
//
//            try (1...24).map { "Episode \($0)" }.forEach {
//                _ = try db.run(episodes.insert(season <- 1, name <- $0))
//            }
//        }
//    }
//
//    static func migrateDatabase(in dbConn: Connection) throws {
//        let manager = SQLiteMigrationManager(db: dbConn,
//                                             migrations: migrations,
//                                             bundle: migrationsBundle)
//        if manager.hasMigrationsTable() == false {
//            try manager.createMigrationsTable()
//        }
//        if manager.needsMigration() {
//            try manager.migrateDatabase()
//        }
//    }
//
//    private static var migrations = {
//        [SeedDB()]
//    }()
//
//    private static var migrationsBundle: Bundle = {
//        guard let bundleURL = Bundle.main.url(forResource: "Migrations", withExtension: "bundle") else {
//            fatalError("could not find migrations bundle")
//        }
//        guard let bundle = Bundle(url: bundleURL) else {
//            fatalError("could not load migrations bundle")
//        }
//
//        return bundle
//    }()
}
