//
//  Feed.swift
//  GithubFeed
//
//  Created by Daniel Vela on 15/06/2019.
//  Copyright © 2019 veladan. All rights reserved.
//

struct Feed {
  var events: [GithubEvent]
  var error: String?

  func loadEvents() {
//    let result = GithubAPI.shared.loadEvents()
//    events = result
  }
}
