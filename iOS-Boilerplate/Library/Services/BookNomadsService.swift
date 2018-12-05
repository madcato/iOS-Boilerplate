//
//  BookNomadsService.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 22/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import Alamofire
import Foundation

class BookNomadsService: NetworkingInjected {
    func getBook(by isbn: String, onOK: @escaping (BookDTO?) -> Void, onError: @escaping (Int, String) -> Void) {
        apiClient.request(API.bookNomadsISBN(isbn)) { result in
            switch result {
            case let .success(book):
                onOK(book)
            case let .error(code, desc):
                onError(code, desc)
            }
        }
    }
}
