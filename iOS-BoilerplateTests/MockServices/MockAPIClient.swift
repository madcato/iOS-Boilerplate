//
//  MockAPIClient.swift
//  iOS-BoilerplateTests
//
//  Created by Daniel Vela Angulo on 05/12/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

@testable import iOS_Boilerplate

class MockAPIClient: Http.Client {
    var objectToReturn: Http.Result<BookDTO>?

    init() {
        super.init(accessToken: "")
    }

    override func request<BookDTO>(_ endpoint: Http.Endpoint<BookDTO>,
                                   completion: @escaping (Http.Result<BookDTO>) -> Void) {
        guard let object = objectToReturn as? Http.Result<BookDTO> else {
            fatalError("Need to set 'objectToReturn' value before calling this method")
        }
        completion(object)
    }
}
