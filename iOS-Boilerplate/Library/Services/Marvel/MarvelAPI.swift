//
//  MarvelAPI.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 03/12/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

// SAMPLE CODE

import BLNetwork
import Foundation

enum MarvelAPI {
  static func characters(_ query: Marvel.CharacterListQuery? = nil) -> Http.Endpoint<Marvel.ResponseDto, Http.NoBody> {
    Http.Endpoint(
      method: .get,
      path: "/characters",
      parameters: getAuthParameters().merging(query?.dictionarized ?? [:]) { _, new in new },
      body: nil
    )
  }

  static func character(_ id: Int) -> Http.Endpoint<Marvel.ResponseDto, Http.NoBody> {
    Http.Endpoint(
      method: .get,
      path: "/characters/\(id)",
      parameters: getAuthParameters(),
      body: nil
    )
  }

  private static func getAuthParameters() -> Http.Parameters {
    let timeStamp = Date().timeIntervalSince1970.description
    let publicKey = "a42b6d2f81c8ca1d0c30e5c99149b8f5"
    let privateKey = "a23b10d30b1a2b726bd2873baa26a0a7220382e6"
    let hash = "\(timeStamp)\(privateKey)\(publicKey)".md5()
    return ["apikey": publicKey, "ts": timeStamp, "hash": hash]
  }
}
