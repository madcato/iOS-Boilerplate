//
//  GithubEventsInteractor.swift
//  GithubFeed
//
//  Created by danielvela on 18/06/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//

protocol GithubEventsInteractorInput {

}

protocol GithubEventsInteractorOutput {
  func presentEvents(response: GithubEventsScene.ListEvents.Response)
  func presentError(_ error: Error)
}

protocol GithubEventsDataSource {
  var selectedEvent: GithubEvent! { get }
}

protocol GithubEventsDataDestination {

}

class GithubEventsInteractor: GithubEventsInteractorInput, GithubEventsDataSource, GithubEventsDataDestination {
  var output: GithubEventsInteractorOutput?
  var worker: GithubEventsWorker?
  var selectedEvent: GithubEvent!
  private var cachedEvents: [GithubEvent] = []
  private var filterStr: String?
  private var filterType: GithubEventsScene.ListEvents.FilterType?

  // MARK: Business logic

  func getEvents(_ request: GithubEventsScene.ListEvents.Request) {
    filterStr = request.filter?.lowercased()
    filterType = request.filterType
    if request.reload {
      loadEvents()
    } else {
      response(cachedEvents)
    }
  }

  func selectEvent(_ request: GithubEventsScene.SelectEvent.Request) {
    selectedEvent = cachedEvents.first { $0.id == request.id }
  }

  // MARK: private helper functions

  private func loadEvents() {
    worker = GithubEventsWorker()
    worker?.doGetEventList { [unowned self] result in
      switch result {
      case .success(let events):
        self.cachedEvents = events
        self.response(events)
      case .failure(let error):
        self.output?.presentError(error)
      }
    }
  }

  private func filter(_ events: [GithubEvent]) -> [GithubEvent] {
    guard let filterStr = self.filterStr,
          let filterType = self.filterType,
          !filterStr.isEmpty else {
        return events
    }
    return events.filter { event -> Bool in
      if filterType == .name {
        if event.actor?.displayLogin.lowercased().contains(filterStr) ?? false {
          return true
        }
      } else {
        if event.repo?.name.lowercased().contains(filterStr) ?? false {
          return true
        }
      }
      return false
    }
  }

  private func response(_ events: [GithubEvent]) {
    let filteredEvents = filter(events)
    let response = GithubEventsScene.ListEvents.Response(events: filteredEvents)
    self.output?.presentEvents(response: response)
  }
}
