//
//  GithubEventDetailViewController.swift
//  GithubFeed
//
//  Created by danielvela on 18/06/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//

import UIKit

protocol GithubEventDetailViewControllerInput {
  func displayEvent(viewModel: GithubEventDetailScene.GetEvent.ViewModel)
}

protocol GithubEventDetailViewControllerOutput {
  func getEvent(request: GithubEventDetailScene.GetEvent.Request)
}

class GithubEventDetailViewController: UIViewController, GithubEventDetailViewControllerInput,
  UITableViewDelegate,
  UITableViewDataSource {
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var avatarImageView: DownloadImageView!
  @IBOutlet private weak var userName: UILabel!
  @IBOutlet private weak var repoName: UILabel!

  var output: GithubEventDetailViewControllerOutput?
  var router: GithubEventDetailRouter?
  var commits: [GithubEventDetailScene.GetEvent.ViewModel.Commit] = []

  // MARK: Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    GithubEventDetailConfigurator.sharedInstance.configure(viewController: self)
  }

  // MARK: View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    getEvent()
  }

  // MARK: Requests
  func getEvent() {
    let request = GithubEventDetailScene.GetEvent.Request()
    output?.getEvent(request: request)
  }

  // MARK: Display logic

  func displayEvent(viewModel: GithubEventDetailScene.GetEvent.ViewModel) {
    avatarImageView.download(from: viewModel.avatarUrl)
    userName.text = viewModel.name
    repoName.text = viewModel.repo
    commits = viewModel.commits
    tableView.reloadData()
  }
}

//This should be on configurator but for some reason storyboard doesn't detect ViewController's name if placed there
extension GithubEventDetailViewController: GithubEventDetailPresenterOutput {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router?.passDataToNextScene(for: segue)
  }

}

// MARK: - UITableView delegate

extension GithubEventDetailViewController {
  func numberOfSections(in tableView: UITableView) -> Int { 1 }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { commits.count }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommitMessageTableViewCell", for: indexPath)
      as? CommitMessageTableViewCell else {
        fatalError("Invalid cell id for CommitMessageTableViewCell")
    }
    let commit = commits[indexPath.row]
    cell.present(commit)
    return cell
  }
}
