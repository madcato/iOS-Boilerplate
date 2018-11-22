//
//  BookNomadsService.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 22/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import Foundation
import Alamofire

class BookNomadsService {
    func getBook(by isbn: String, onOK: @escaping (BookDTO?) -> Void, onError: @escaping (Int, String) -> Void) {
        Alamofire.request("https://www.booknomads.com/api/v0/isbn/\(isbn)")
            .validate()
            .responseJSON { response in
                guard case let .failure(error) = response.result else {
                    do{
                        guard let json = response.data else {
                            return
                        }
                        let decoder = JSONDecoder()
                        let book = try decoder.decode(BookDTO.self, from: json)
                        onOK(book)
                    }catch let err{
                        print(err)
                    }
                    return
                }
                onError(response.response?.statusCode ?? 0,error.localizedDescription)
        }

    }
}
