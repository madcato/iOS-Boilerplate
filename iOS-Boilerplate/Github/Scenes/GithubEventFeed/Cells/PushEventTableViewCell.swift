//
//  PushEventTableViewCell.swift
//  GithubFeed
//
//  Created by Daniel Vela on 16/06/2019.
//  Copyright © 2019 veladan. All rights reserved.
//

import UIKit

class PushEventTableViewCell: GithubEventTableViewCell {
  @IBOutlet private weak var lastMessageLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }

  override func present(event: GithubEventsScene.ListEvents.ViewModel.Event) {
    super.present(event: event)
    lastMessageLabel.text = event.commitMessage
    accessoryType = AccessoryType.disclosureIndicator
  }
}
