//
//  GithubAPI.swift
//  GithubFeed
//
//  Created by Daniel Vela on 15/06/2019.
//  Copyright © 2019 veladan. All rights reserved.
//

import Foundation
import UIKit

enum GithubServiceError: Error {
  case offline
  case githubLimitReached
  case networkError
  case serviceError
  case jsonError
}

typealias GithubEventsResponse = Result<[GithubEvent], GithubServiceError>

/// Use this class to access Github API
/// Use *sharedAPI* static property to access the singleting object
class GithubAPI {

  /// Singleton for the Github API
  static var shared = GithubAPI()

  lazy var session: URLSession = {
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil
    return URLSession(configuration: config)
  }()

  let baseURL = "https://api.github.com/"

  /// Download event list fro github api
  /// - parameter onFinish: block to be called when download finish
  func getEvents(onFinish: @escaping (Result<Data, Error>) -> Void) {
    let urlString = "\(baseURL)events"
    guard let url = URL(string: urlString) else {
      fatalError("Invalid event github api url")
    }
    let dataTask = session.dataTask(with: url) { data, _, error in
      if let error = error {
        onFinish(Result.failure(error))
        return
      }
      if let data = data {
        onFinish(Result.success(data))
        return
      }
    }
    dataTask.resume()
  }
}

#if DEBUG
class GithubAPIStub: GithubAPI {
  var produceError: Bool = false

  override func getEvents(onFinish: @escaping (Result<Data, Error>) -> Void) {
    if produceError {
      onFinish(.failure(GithubServiceError.offline))
    }
    guard let data = TestHelper().loadFileToData("eventsList", ofType: "json") else {
      fatalError("Fail loading 'eventList.json' file")
    }
    onFinish(.success(data))
  }
}
#endif
