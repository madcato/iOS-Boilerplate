//
//  MarvelService.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 14/4/21.
//

import Alamofire

struct MarvelServiceError: Error {
    var id: Int
    var description: String
}

class MarvelService: NetworkingInjected {
    private var serverUrl = ""

    func listCharacters(_ onFinish: @escaping (Http.Result<[Marvel.CharacterDto]>) -> Void) {
        apiClient.request(MarvelAPI.characters()) { result in
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
        apiClient.request(MarvelAPI.character(id)) { result in
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
