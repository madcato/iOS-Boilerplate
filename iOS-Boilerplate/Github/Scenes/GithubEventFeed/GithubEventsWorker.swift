//
//  GithubEventsWorker.swift
//  GithubFeed
//
//  Created by danielvela on 18/06/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//

import Foundation

typealias GithubEventResult = Result<[GithubEvent], Error>

class GithubEventsWorker {
  // MARK: Business Logic

  /// Download the event list from the github api
  func doGetEventList(onFinish: @escaping (GithubEventResult) -> Void) {
    GithubAPI.shared.getEvents { [unowned self] result in
      let reduction = self.reduce(result)
      if Thread.current.isMainThread {
        onFinish(reduction)
      } else {
        DispatchQueue.main.async {
          onFinish(reduction)
        }
      }
    }
  }

  /// Reduce the result from the github api to the Result type
  /// This method parses the json from the github api.
  /// In case of error from the api conection, returns it.
  /// - parameter result: The result from the api get method.
  /// - returns: The processed result with the parsed *GithubEvent* list
  ///            in case of api get success
  func reduce(_ result: Result<Data, Error>) -> GithubEventResult {
    switch result {
    case .success(let data):
      do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let events = try decoder.decode([GithubEvent].self, from: data)
        return .success(events)
      } catch {
        fatalError("Error decoding: \(error.localizedDescription)")
      }
    case .failure(let error):
      return .failure(error)
    }
  }
}
