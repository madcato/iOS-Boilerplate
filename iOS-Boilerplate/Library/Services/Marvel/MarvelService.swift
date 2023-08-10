//
//  MarvelService.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 14/4/21.
//

struct MarvelServiceError: Error {
    var id: Int
    var description: String
}

class MarvelService {
    private var marvelAPIClient = Http.Client(baseURL: "https://gateway.marvel.com",
                                              basePath: "/v1/public",
                                              defaultHeaders: ["Accept": "application/json",
                                                               "secret": "a42b6d2f81c8ca1d0c30e5c99149b8f5"])

    func listCharacters() async throws -> [Marvel.CharacterDto] {
        let response: Marvel.ResponseDto = try await marvelAPIClient.request(MarvelAPI.characters())
        return response.data!.results!
    }

    func characterDetail(with id: Int) async throws -> Marvel.CharacterDto {
        let response = try await marvelAPIClient.request(MarvelAPI.character(id))
        return (response.data!.results?.first)!
    }

}
