//
//  GithubEventsViewController.swift
//  GithubFeed
//
//  Created by danielvela on 18/06/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//

import UIKit

protocol GithubEventsViewControllerInput {
  func displayEvents(viewModel: GithubEventsScene.ListEvents.ViewModel)
}

protocol GithubEventsViewControllerOutput {
  func getEvents(_ request: GithubEventsScene.ListEvents.Request)
  func selectEvent(_ request: GithubEventsScene.SelectEvent.Request)
}

class GithubEventsViewController: UITableViewController, GithubEventsViewControllerInput {
  var output: GithubEventsViewControllerOutput?
  var router: GithubEventsRouter?
  var events: [GithubEventsScene.ListEvents.ViewModel.Event] = []

  @IBOutlet private weak var searchBar: UISearchBar!

  // MARK: Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    GithubEventsConfigurator.sharedInstance.configure(viewController: self)
  }

  // MARK: View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableViewOnLoad()
    configureRefreshControl()

    loadEvents(reload: true)
  }

  // MARK: Requests

  func loadEvents(reload: Bool) {
    let str = searchBar.text
    let type = GithubEventsScene.ListEvents.FilterType(rawValue: searchBar.selectedScopeButtonIndex)
    let request = GithubEventsScene.ListEvents.Request(filter: str,
                                                       filterType: type,
                                                       reload: reload)
    output?.getEvents(request)
  }

  // MARK: Display logic

  func displayEvents(viewModel: GithubEventsScene.ListEvents.ViewModel) {
    refreshControl?.endRefreshing()
    events = viewModel.events
    tableView.reloadData()
  }

  func displayError(string: String) {
    self.refreshControl?.endRefreshing()
    showAlert(string)
  }
}

extension GithubEventsViewController: GithubEventsPresenterOutput {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router?.passDataToNextScene(for: segue)
  }
}

// MARK: - UITableViewDatasource

extension GithubEventsViewController {

  func configureTableViewOnLoad() {

  }

  func configureRefreshControl() {
    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
  }

  @objc
  func refreshData() {
    self.loadEvents(reload: true)
  }

  override func numberOfSections(in tableView: UITableView) -> Int { 1 }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    events.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let displayEvent = events[indexPath.row]
    let eventCell = cellFor(displayEvent, in: tableView, for: indexPath)
    return eventCell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    /// If event type is PushEvent show a detail view
    /// If not, show a UIAlertController to the user asking to navigate user or repo URLs.
    let event = events[indexPath.row]
    if event.type == GithubEvent.EventType.push {
      let request = GithubEventsScene.SelectEvent.Request(id: event.id)
      output?.selectEvent(request)
      router?.navigateToEventDetailScene()
    } else {
      showAskUserForNavigation(for: event)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

// MARK: - Cell GithubEvent

extension GithubEventsViewController {
  func cellFor(_ event: GithubEventsScene.ListEvents.ViewModel.Event,
               in tableView: UITableView,
               for indexPath: IndexPath) -> UITableViewCell {
    var cell: UITableViewCell!
    switch event.type {
    case .push:
      cell = tableView.dequeueReusableCell(withIdentifier: "PushEventCell", for: indexPath)
    default:
      cell = tableView.dequeueReusableCell(withIdentifier: "DefaultEventCell", for: indexPath)
    }
    guard let eventCell = cell as? GithubEventTableViewCell else {
      fatalError("Invalid Github Event Cell type")
    }
    eventCell.present(event: event)
    return eventCell
  }
}

// MARK: - Ask user for navigation

extension GithubEventsViewController {
  func showAskUserForNavigation(for event: GithubEventsScene.ListEvents.ViewModel.Event) {
    let activity = UIAlertController(title: "Navigate to", message: nil, preferredStyle: .actionSheet)
    activity.addAction(UIAlertAction(title: "User profile API URL",
                                     style: UIAlertAction.Style.default) { _ in
                                      guard let url = URL(string: event.actorUrl) else {
                                        return
                                      }
                                      UIApplication.shared.open(url)
    })
    activity.addAction(UIAlertAction(title: "Repository API URL",
                                     style: UIAlertAction.Style.default) { _ in
                                      guard let url = URL(string: event.repoUrl) else {
                                        return
                                      }
                                      UIApplication.shared.open(url)
    })
    activity.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive))
    self.present(activity, animated: true)
  }
}

// MARK: - UISearchBarDelegate

extension GithubEventsViewController: UISearchBarDelegate {
  /// Called when the user taps one of the scopes of the search bar
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    loadEvents(reload: false)
  }

  /// Called when the user changes the search text
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    loadEvents(reload: false)
  }

}
