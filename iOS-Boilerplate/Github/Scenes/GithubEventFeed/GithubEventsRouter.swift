//
//  GithubEventsRouter.swift
//  GithubFeed
//
//  Created by danielvela on 18/06/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//

import UIKit

protocol GithubEventsRouterInput {
}

protocol GithubEventsRouterDataSource: AnyObject {
  var selectedEvent: GithubEvent! { get }
}

protocol GithubEventsRouterDataDestination: AnyObject {
}

class GithubEventsRouter: GithubEventsRouterInput {
  weak var viewController: GithubEventsViewController!
  weak var dataDestination: GithubEventsRouterDataDestination!
  private weak var dataSource: GithubEventsRouterDataSource!

  enum SegueIdentifiers {
    static let eventDetail = "ShowDetail"
  }

  init(viewController: GithubEventsViewController,
       dataSource: GithubEventsRouterDataSource,
       dataDestination: GithubEventsRouterDataDestination) {
    self.viewController = viewController
    self.dataSource = dataSource
    self.dataDestination = dataDestination
  }

  // MARK: Navigation

  func navigateToEventDetailScene() {
    viewController.performSegue(withIdentifier: SegueIdentifiers.eventDetail, sender: viewController)
  }

  // MARK: Communication

  func passDataToNextScene(for segue: UIStoryboardSegue) {
    guard let segueIdentifier = segue.identifier else {
      return
    }
    switch segueIdentifier {
    case SegueIdentifiers.eventDetail:
      passDataToEventDetail(for: segue)
    default:
      return
    }
  }

  private func passDataToEventDetail(for segue: UIStoryboardSegue) {
    if let eventDetailViewController = segue.destination as? GithubEventDetailViewController {
      eventDetailViewController.router?.dataDestination.event = dataSource.selectedEvent
    }
  }
}
