//
//  MarvelDownloader.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 15/8/23.
//  Copyright © 2023 veladan. All rights reserved.
//

import Foundation

/// This class downloads a limited amount of Marvel characters and stores them into
/// a CoreDataStack, wihtout duplicates
class MarvelDownloader {
    private let downloadLimit = 100
    private let database: CoreDataStack!
    private let service: MarvelService!

    init(with database: CoreDataStack, and service: MarvelService) {
        self.database = database
        self.service = service
    }

    func downloadAndStoreCharacters() async throws {
            let query = Marvel.CharacterListQuery(limit: downloadLimit)
            let characterList = try await service.listCharacters(query)
            characterList.forEach { character in
                guard database.getObject(ofType: "MarvelCharacter",
                                         Where(predicate: "marvelId == %@", arguments: [character.id])) == nil else {
                    // This character already exits
                    return
                }
                guard let object = database.createObject(entityName: "MarvelCharacter") as? MarvelCharacter else {
                    fatalError("Imposible to create MarvelCharacter CoreData object")
                }

                object.charactherDescription = character.description
                object.marvelId = Int64(character.id)
                object.name = character.name
                object.resourceUrl = character.urls?.first?.url
                object.thumbnailUrl = character.thumbnail?.urlString
                object.favourite = false
            }
        database.saveContext()
    }
}
