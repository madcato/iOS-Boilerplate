//
//  GithubEventDetailRouter.swift
//  GithubFeed
//
//  Created by danielvela on 18/06/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//

import UIKit

protocol GithubEventDetailRouterInput {

}

protocol GithubEventDetailRouterDataSource: AnyObject {

}

protocol GithubEventDetailRouterDataDestination: AnyObject {
  var event: GithubEvent! { get set }
}

class GithubEventDetailRouter: GithubEventDetailRouterInput {
  weak var viewController: GithubEventDetailViewController!
  weak var dataDestination: GithubEventDetailRouterDataDestination!
  private weak var dataSource: GithubEventDetailRouterDataSource!

  init(viewController: GithubEventDetailViewController,
       dataSource: GithubEventDetailRouterDataSource,
       dataDestination: GithubEventDetailRouterDataDestination) {
    self.viewController = viewController
    self.dataSource = dataSource
    self.dataDestination = dataDestination
  }

  // MARK: Navigation

  // MARK: Communication

  func passDataToNextScene(for segue: UIStoryboardSegue) {
    // NOTE: Teach the router which scenes it can communicate with
  }
}
