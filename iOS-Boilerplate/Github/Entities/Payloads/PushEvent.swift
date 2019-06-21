//
//  PushEvent.swift
//  GithubFeed
//
//  Created by Daniel Vela on 16/06/2019.
//  Copyright © 2019 veladan. All rights reserved.
//

import Foundation

struct Author: Decodable {
  var email: String = ""
  var name: String = ""

}

struct Commit: Decodable {
  var sha: String = ""
  var author: Author?
  var message: String = ""
  var distinct: Bool = false
  var url: String = ""
}

/// Triggered on a push to a repository branch.
/// Branch pushes and repository tag pushes also trigger webhook push events.
struct PushEvent: Payload, Decodable {
  var pushId: Int = 0
  var size: Int = 0
  var distinctSize: Int = 0
  var ref: String = ""
  var head: String = ""
  var before: String = ""
  var commits: [Commit] = []

  enum CodingKeys: String, CodingKey {
    case pushId = "push_id"
    case size
    case distinctSize = "distinct_size"
    case ref
    case head
    case before
    case commits
  }
}
