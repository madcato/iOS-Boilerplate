//
//  GithubEvent.swift
//  GithubFeed
//
//  Created by Daniel Vela on 15/06/2019.
//  Copyright © 2019 veladan. All rights reserved.
//

import Foundation

struct Repository: Decodable {
  var id: Int
  var name: String
  var url: String
}

struct Actor: Decodable {
  var id: Int = 0
  var login: String = ""
  var displayLogin: String = ""
  var gravatarId: String = ""
  var avatarUrl: String = ""
  var url: String = ""

  enum CodingKeys: String, CodingKey {
    case gravatarId = "gravatar_id"
    case displayLogin = "display_login"
    case avatarUrl = "avatar_url"
    case url
    case login
    case id
  }
}

struct Organization: Codable {
  var id: Int = 0
  var login: String = ""
  var gravatarId: String = ""
  var avatarUrl: String?
  var url: String = ""

  enum CodingKeys: String, CodingKey {
    case gravatarId = "gravatar_id"
    case avatarUrl = "avatar_url"
  }
}

protocol Payload {
}

struct GithubEvent: Decodable {
  enum EventType: String, Decodable {
    case star = "StarEvent"
    case watch = "WatchEvent"
    case push = "PushEvent"
    case create = "CreateEvent"
    case unknown
  }

  var type: EventType
  var repo: Repository?
  var actor: Actor?
  var org: Organization?
  var createdAt: Date?
  var id: String = ""
  var payload: Payload?

  enum CodingKeys: String, CodingKey {
    case createdAt = "created_at"
    case type, repo, actor, org, id, payload
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    repo = try values.decodeIfPresent(Repository.self, forKey: .repo)
    actor = try values.decodeIfPresent(Actor.self, forKey: .actor)
    org = try values.decodeIfPresent(Organization.self, forKey: .org)
    createdAt = try values.decodeIfPresent(Date.self, forKey: .createdAt)
    id = try values.decode(String.self, forKey: .id)
    let typeRaw = try values.decodeIfPresent(String.self, forKey: .type)
    guard let decodedType = EventType(rawValue: typeRaw ?? "") else {
      type = .unknown
      return
    }
    type = decodedType
    switch type {
    case .create:
      payload = try values.decode(CreateEvent.self, forKey: .payload)
    case .push:
      payload = try values.decode(PushEvent.self, forKey: .payload)
    case .star:
      payload = try values.decode(StarEvent.self, forKey: .payload)
    case .watch:
      payload = try values.decode(WatchEvent.self, forKey: .payload)
    default:
      payload = nil
    }
  }
}
