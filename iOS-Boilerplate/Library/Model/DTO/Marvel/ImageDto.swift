//
//  ImageDto.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 15/4/21.
//

import Foundation

struct ImageDto: Decodable {
    enum ImageKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }

    let url: URL
    let urlString: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)

        let path = try container.decode(String.self, forKey: .path)
        let fileExtension = try container.decode(String.self, forKey: .fileExtension)

        self.urlString = "\(path).\(fileExtension)"
        guard let url = URL(string: self.urlString) else {
            fatalError("Invalid Marvel image format in json")
        }

        self.url = url
    }
}
