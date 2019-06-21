//
//  CommitMessageTableViewCell.swift
//  GithubFeed
//
//  Created by danielvela on 20/06/2019.
//  Copyright © 2019 veladan. All rights reserved.
//

import UIKit

class CommitMessageTableViewCell: UITableViewCell {
  @IBOutlet private weak var shaLabel: UILabel!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  func present(_ commit: GithubEventDetailScene.GetEvent.ViewModel.Commit) {
    shaLabel.text = commit.sha
    nameLabel.text = commit.nameEmail
    messageLabel.text = commit.message
  }

}
