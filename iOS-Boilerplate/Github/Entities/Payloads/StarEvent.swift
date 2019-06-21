//
//  StarEvent.swift
//  GithubFeed
//
//  Created by Daniel Vela on 16/06/2019.
//  Copyright © 2019 veladan. All rights reserved.
//

import Foundation

/// Triggered when a star is added or removed from a repository.
struct StarEvent: Payload, Codable {
  var action: String = ""
  var starredAt: Date?

  enum CodingKeys: String, CodingKey {
    case action
    case starredAt = "starred_at"
  }
}
