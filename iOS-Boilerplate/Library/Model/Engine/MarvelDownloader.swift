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
                guard MarvelCharacter.getObject(by: "marvelId", equalTo: character.id, in: database) == nil else {
                    // This character already exits
                    return
                }
                guard let object = MarvelCharacter.create(in: database) else {
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
