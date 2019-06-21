//
//  GithubEventDetailPresenter.swift
//  GithubFeed
//
//  Created by danielvela on 18/06/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//

protocol GithubEventDetailPresenterInput {
  func presentEvent(response: GithubEventDetailScene.GetEvent.Response)
}

protocol GithubEventDetailPresenterOutput: AnyObject {
  func displayEvent(viewModel: GithubEventDetailScene.GetEvent.ViewModel)
}

class GithubEventDetailPresenter: GithubEventDetailPresenterInput {
  weak var output: GithubEventDetailPresenterOutput?

  // MARK: Presentation logic

  func presentEvent(response: GithubEventDetailScene.GetEvent.Response) {
    let event = response.event
    let viewModel = createViewModel(from: event)
    output?.displayEvent(viewModel: viewModel)
  }

  private func createViewModel(from event: GithubEvent?) -> GithubEventDetailScene.GetEvent.ViewModel {
    guard let pushEvent = event?.payload as? PushEvent else {
      fatalError("PushEvent is required to convert to ViewModel.PushEvent")
    }
    let commits = pushEvent.commits.map { commit -> GithubEventDetailScene.GetEvent.ViewModel.Commit in
      let nameEmail = "\(commit.author?.name ?? "") - \(commit.author?.email ?? "")"
      return GithubEventDetailScene.GetEvent.ViewModel.Commit(sha: commit.sha,
                                                              nameEmail: nameEmail,
                                                              message: commit.message)
    }
    return GithubEventDetailScene.GetEvent.ViewModel(avatarUrl: event?.actor?.avatarUrl ?? "",
                                                     name: event?.actor?.displayLogin ?? "",
                                                     repo: event?.repo?.name ?? "",
                                                     commits: commits)
  }
}
