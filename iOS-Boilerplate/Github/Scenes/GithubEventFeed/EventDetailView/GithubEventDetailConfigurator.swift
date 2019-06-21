//
//  GithubEventDetailConfigurator.swift
//  GithubFeed
//
//  Created by danielvela on 18/06/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension GithubEventDetailInteractor: GithubEventDetailViewControllerOutput,
                                       GithubEventDetailRouterDataSource,
                                       GithubEventDetailRouterDataDestination {

}

extension GithubEventDetailPresenter: GithubEventDetailInteractorOutput {

}

class GithubEventDetailConfigurator {
  // MARK: Object lifecycle

  static let sharedInstance = GithubEventDetailConfigurator()

  private init() {}

  // MARK: Configuration

  func configure(viewController: GithubEventDetailViewController) {
    let presenter = GithubEventDetailPresenter()
    presenter.output = viewController

    let interactor = GithubEventDetailInteractor()
    interactor.output = presenter

    let router = GithubEventDetailRouter(viewController: viewController,
                                         dataSource: interactor,
                                         dataDestination: interactor)

    viewController.output = interactor
    viewController.router = router
  }

}
