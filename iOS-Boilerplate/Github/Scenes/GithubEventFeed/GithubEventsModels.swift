//
//  GithubEventsModels.swift
//  GithubFeed
//
//  Created by danielvela on 18/06/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//
//
//  Type "usecase" for some magic!

import Foundation
import UIKit

enum GithubEventsScene {
  enum ListEvents {
    enum FilterType: Int {
      case name = 0
      case repo = 1
    }
    struct Request {
      var filter: String?
      // Set to null 
      var filterType: FilterType?
      /// Set to true to force the reload of events
      var reload: Bool
    }

    struct Response {
      let events: [GithubEvent]
    }

    struct ViewModel {
      let events: [Event]

      struct Event {
        var id: String
        var informationText: NSAttributedString
        var avatarUrl: String
        var type: GithubEvent.EventType
        var actorUrl: String
        var repoUrl: String
        var color: UIColor?
        var commitMessage: String?
      }
    }
  }

  enum SelectEvent {
    struct Request {
      var id: String
    }
  }
}
