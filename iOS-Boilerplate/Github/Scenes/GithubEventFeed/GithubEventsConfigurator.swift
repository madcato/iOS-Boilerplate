//
//  GithubEventsConfigurator.swift
//  GithubFeed
//
//  Created by danielvela on 18/06/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension GithubEventsInteractor: GithubEventsViewControllerOutput,
                                  GithubEventsRouterDataSource,
                                  GithubEventsRouterDataDestination {

}

extension GithubEventsPresenter: GithubEventsInteractorOutput {

}

class GithubEventsConfigurator {
  // MARK: Object lifecycle

  static let sharedInstance = GithubEventsConfigurator()

  private init() {}

  // MARK: Configuration

  func configure(viewController: GithubEventsViewController) {
    let presenter = GithubEventsPresenter()
    presenter.output = viewController

    let interactor = GithubEventsInteractor()
    interactor.output = presenter

    let router = GithubEventsRouter(viewController: viewController, dataSource: interactor, dataDestination: interactor)

    viewController.output = interactor
    viewController.router = router
  }

}
