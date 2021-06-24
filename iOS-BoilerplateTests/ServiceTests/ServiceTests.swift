//
//  ServiceTests.swift
//  iOS-BoilerplateTests
//
//  Created by Daniel Vela Angulo on 03/12/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

@testable import iOS_Boilerplate
import Nimble
import Quick
import XCTest

class ServiceTests: QuickSpec {
    override func spec() {
        describe("NetworkRequest") {  // swiftlint:disable:this closure_body_length
            var networkService: MarvelService?

            beforeEach {
                NetworkingInjector.apiClient = Http.Client()
                networkService = MarvelService()
            }

            context("get character") {
                it("should return a json of type ResponseDto when server response is a json object") {
                    var character: Marvel.CharacterDto?
                    let id = 1_011_334
                    waitUntil(timeout: .seconds(10)) { done in
                        networkService?.characterDetail(of: id) { result in
                            switch result {
                            case let .success(response):
                                character = response
                            case let .error(_, strError):
                                print("\(strError)")
                            }
                            done()
                        }
                    }
                    expect(character).toEventuallyNot(beNil())
                    let expectedCharacter = Marvel.CharacterDto(id: id,
                                                                name: "3-D Man",
                                                                description: "",
                                                                thumbnail: nil,
                                                                urls: nil)
                    expect(character?.id).toEventually(equal(expectedCharacter.id))
                    expect(character?.name).toEventually(equal(expectedCharacter.name))
                    expect(character?.description).toEventually(equal(expectedCharacter.description))
                }
            }
        }
    }
}
