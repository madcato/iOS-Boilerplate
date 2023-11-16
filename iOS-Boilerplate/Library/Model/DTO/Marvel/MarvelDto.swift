//
//  MarvelDto.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 14/4/21.
//

import BLUtility
import Foundation

enum Marvel {

// MARK: - MarvelDto main response

struct ResponseDto: Decodable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    var data: DataDto?
}

// MARK: - Marvel Data

struct DataDto: Decodable {
    let offset, limit, total, count: Int?
    var results: [CharacterDto]?
}

// MARK: - Marvel Character

struct CharacterDto: Decodable {
    let id: Int
    let name: String?
    let description: String?
    let thumbnail: ImageDto?
    let urls: [UrlDto]?

    func detailURL() -> String {
        urls?.first { $0.type == "detail" }?.url ?? "http://www.marvel.com"
    }
}

struct UrlDto: Decodable {
    let type: String?
    let url: String?

}

// MARK: - Marvel character Request

/// This class represents the parameters that may be sent to the '/v1/public/characters' marvel enpoint
struct CharacterListQuery: Dictionarizable {
    /// Return only characters matching the specified full character name (e.g. Spider-Man).
    var name: String?
    /// Return characters with names that begin with the specified string (e.g. Sp).
    var nameStartsWith: String?
    /// Return only characters which have been modified since the specified date.
    var modifiedSince: Date?
    /// Return only characters which appear in the specified comics (accepts a comma-separated list of ids).
    var comics: Int?
    /// Return only characters which appear the specified series (accepts a comma-separated list of ids).
    var series: Int?
    /// Return only characters which appear in the specified events (accepts a comma-separated list of ids).
    var events: Int?
    /// Return only characters which appear the specified stories (accepts a comma-separated list of ids).
    var stories: Int?
    /// Order the result set by a field or fields. Add a "-" to the value sort in descending order.
    /// Multiple values are given priority in the order in which they are passed.
    /// Values:
    ///   - name
    ///   - modified
    ///   - -name
    ///   - -modified
    var orderBy: String?
    /// Limit the result set to the specified number of resources.
    var limit: Int?
    /// Skip the specified number of resources in the result set.
    var offset: Int?

    var dictionarized: [String: Any] {
        let keys = ["name", "nameStartsWith", "modifiedSince", "comics", "series", "events",
                    "stories", "orderBy", "stories", "orderBy", "limit", "offset"]
        let values: [Any?] = [name, nameStartsWith, modifiedSince, comics, series,
                              events, stories, orderBy, stories, orderBy, limit, offset]
        return dictionarize(keys, values)
    }
}
}
