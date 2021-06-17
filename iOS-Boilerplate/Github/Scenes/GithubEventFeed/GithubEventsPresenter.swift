//
//  GithubEventsPresenter.swift
//  GithubFeed
//
//  Created by danielvela on 18/06/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//

import UIKit

protocol GithubEventsPresenterInput {
  func presentEvents(response: GithubEventsScene.ListEvents.Response)
}

protocol GithubEventsPresenterOutput: AnyObject {
  func displayEvents(viewModel: GithubEventsScene.ListEvents.ViewModel)
  func displayError(string: String)
}

class GithubEventsPresenter: GithubEventsPresenterInput {
  weak var output: GithubEventsPresenterOutput?

  // MARK: Presentation logic

  func presentEvents(response: GithubEventsScene.ListEvents.Response) {
    let events = createViewModel(from: response.events)
    let viewModel = GithubEventsScene.ListEvents.ViewModel(events: events)
    output?.displayEvents(viewModel: viewModel)
  }

  func presentError(_ error: Error) {
    output?.displayError(string: "Error downloading event list. Retry later. \(error.localizedDescription)")
  }

  private func createViewModel(from events: [GithubEvent]) -> [GithubEventsScene.ListEvents.ViewModel.Event] {
    events.map {
      let attributedString = format(userName: $0.actor?.displayLogin ?? "",
                                    eventType: eventTypeStr(for: $0.type),
                                    repo: $0.repo?.name ?? "")
      let color = triangleColor(for: $0.type)
      var commitMessage: String?
      if let payload = $0.payload as? PushEvent {
        if let commit = payload.commits.first {
          commitMessage = commit.message
        } else {
          commitMessage = "None"
        }
      }
      return GithubEventsScene.ListEvents.ViewModel.Event(id: $0.id,
                                                          informationText: attributedString,
                                                          avatarUrl: $0.actor?.avatarUrl ?? "",
                                                          type: $0.type,
                                                          actorUrl: $0.actor?.url ?? "",
                                                          repoUrl: $0.repo?.url ?? "",
                                                          color: color,
                                                          commitMessage: commitMessage)
    }
  }

  /// Call this method to transform the informational text from
  /// the user name, event type and target repo to an attributed string
  /// - parameter userName: first part of the text
  /// - parameter eventType: second part of the text
  /// - parameter repo: final part of the text
  /// - returns: A NSAttributedString with the text formatted
  private func format(userName: String, eventType: String, repo: String) -> NSAttributedString {
    let font = UIFont.systemFont(ofSize: 14.0)
    let attributedStr1 = NSMutableAttributedString(string: userName, attributes:
      [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: font])
    let attributedStr2 = NSMutableAttributedString(string: " \(eventType)", attributes:
      [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: font])
    let attributedStr3 = NSMutableAttributedString(string: " on \(repo) repository", attributes:
      [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: font])
    attributedStr1.append(attributedStr2)
    attributedStr1.append(attributedStr3)
    return attributedStr1
  }

  /// - returns: The string to show for each event type.
  private func eventTypeStr(for type: GithubEvent.EventType) -> String {
    switch type {
    case .star:
      return "starred"
    case .watch:
      return "start watching"
    case .push:
      return "did branch push"
    case .create:
      return "create"
    case .unknown:
      return "unknown event"
    }
  }

  /// - returns: The color to show for each event type.
  private func triangleColor(for type: GithubEvent.EventType) -> UIColor? {
    switch type {
    case .star:
      return UIColor.yellow
    case .watch:
      return UIColor.red
    case .push:
      return UIColor.green
    case .create:
      return UIColor.blue
    case .unknown:
      return UIColor.clear
    }
  }
}
