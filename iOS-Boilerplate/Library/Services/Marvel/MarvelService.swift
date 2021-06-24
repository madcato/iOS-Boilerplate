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
    private var serverUrl = ""

    func listCharacters(_ onFinish: @escaping (Http.Result<[Marvel.CharacterDto]>) -> Void) {
        marvelAPIClient.request(MarvelAPI.characters()) { result in
            switch result {
            case let .success(response):
                guard let array = response.data?.results else {
                    let description = "Invalid response from Marvel API: list characters"
                    onFinish(Http.Result<[Marvel.CharacterDto]>.error(0, description))
                    return
                }
                onFinish(Http.Result.success(array))
            case let .error(id, description):
                onFinish(Http.Result<[Marvel.CharacterDto]>.error(id, description))
            }
        }
    }

    func characterDetail(of id: Int, _ onFinish: @escaping (Http.Result<Marvel.CharacterDto>) -> Void) {
        marvelAPIClient.request(MarvelAPI.character(id)) { result in
            switch result {
            case let .success(response):
                guard let dto = response.data?.results?[0] else {
                    let description = "Invalid response from Marvel API: character datail"
                    onFinish(Http.Result<Marvel.CharacterDto>.error(0, description))
                    return
                }
                onFinish(Http.Result.success(dto))
            case let .error(id, description):
                onFinish(Http.Result<Marvel.CharacterDto>.error(id, description))
            }
        }
    }

}
