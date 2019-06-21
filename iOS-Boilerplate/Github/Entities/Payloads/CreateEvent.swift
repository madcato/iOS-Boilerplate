//
//  CreateEvent.swift
//  GithubFeed
//
//  Created by Daniel Vela on 16/06/2019.
//  Copyright © 2019 veladan. All rights reserved.
//

import Foundation

/// Represents a created branch or tag.
struct CreateEvent: Payload, Decodable {
  var ref: String?
  var refType: String?
  var masterBranch: String?
  var description: String?
  var pusherType: String?

  enum CodingKeys: String, CodingKey {
    case ref
    case refType = "ref_type"
    case masterBranch = "master_branch"
    case description
    case pusherType = "pusher_type"
  }
}
