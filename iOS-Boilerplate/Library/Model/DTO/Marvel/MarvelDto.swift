//
//  MarvelDto.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 14/4/21.
//

import Foundation

struct ResponseDto2: Decodable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
}

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
}
