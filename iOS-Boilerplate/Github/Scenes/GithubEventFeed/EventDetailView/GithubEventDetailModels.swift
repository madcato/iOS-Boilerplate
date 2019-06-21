//
//  GithubEventDetailModels.swift
//  GithubFeed
//
//  Created by danielvela on 18/06/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//
//
//  Type "usecase" for some magic!

enum GithubEventDetailScene {
  enum GetEvent {
    struct Request {

    }

    struct Response {
      var event: GithubEvent!
    }

    struct ViewModel {
      var avatarUrl: String
      var name: String
      var repo: String
      var commits: [Commit]

      struct Commit {
        var sha: String
        var nameEmail: String
        var message: String
      }
    }
  }
}
