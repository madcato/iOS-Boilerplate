//
//  TestHelper.swift
//  GithubFeedTests
//
//  Created by danielvela on 19/06/2019.
//  Copyright © 2019 veladan. All rights reserved.
//

import Foundation

class TestHelper {
  func loadFileToData(_ name: String, ofType: String) -> Data? {
    let testBundle = Bundle(for: type(of: self))
    if let path = testBundle.path(forResource: name, ofType: ofType) {
      if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
        return data
      }
    }
    return nil
  }
}
