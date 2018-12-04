//
//  BookDTO.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 22/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import Foundation

class BookDTO: Codable, AutoEquatable {
    enum CodingKeys: String, CodingKey {
        case isbn = "ISBN"
        case title = "Title"
        case subtitle = "Subtitle"
        case description = "Description"
        case coverThumb = "CoverThumb"
        case languageCode = "LanguageCode"
        case subjects = "Subjects"
        case authors = "Authors"
    }

    var isbn: String = ""
    var title: String = ""
    var subtitle: String = ""
    var description: String = ""
    var coverThumb: String = ""
    var languageCode: String = ""
    var subjects: [String] = []
    var authors: [[String: String]] = []
}
