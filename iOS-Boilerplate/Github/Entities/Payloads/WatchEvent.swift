//
//  WatchEvent.swift
//  GithubFeed
//
//  Created by Daniel Vela on 16/06/2019.
//  Copyright © 2019 veladan. All rights reserved.
//

/// Triggered when someone stars a repository.
struct WatchEvent: Payload, Codable {
  var action: String = ""
}
