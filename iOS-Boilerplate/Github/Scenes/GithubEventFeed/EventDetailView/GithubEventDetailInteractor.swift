//
//  GithubEventDetailInteractor.swift
//  GithubFeed
//
//  Created by danielvela on 18/06/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//

protocol GithubEventDetailInteractorInput {
  func getEvent(request: GithubEventDetailScene.GetEvent.Request)
}

protocol GithubEventDetailInteractorOutput {
  func presentEvent(response: GithubEventDetailScene.GetEvent.Response)
}

protocol GithubEventDetailDataSource {
}

protocol GithubEventDetailDataDestination {
}

class GithubEventDetailInteractor: GithubEventDetailInteractorInput,
                                   GithubEventDetailDataSource,
                                   GithubEventDetailDataDestination {
  var output: GithubEventDetailInteractorOutput?

  var event: GithubEvent!

  // MARK: Business logic

  func getEvent(request: GithubEventDetailScene.GetEvent.Request) {
    let response = GithubEventDetailScene.GetEvent.Response(event: event)
    output?.presentEvent(response: response)
  }
}
