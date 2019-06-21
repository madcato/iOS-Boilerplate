//
//  GithubEventTableViewCell.swift
//  GithubFeed
//
//  Created by Daniel Vela on 16/06/2019.
//  Copyright © 2019 veladan. All rights reserved.
//

import UIKit

class GithubEventTableViewCell: UITableViewCell {
  @IBOutlet private weak var avatarImageView: DownloadImageView!
  @IBOutlet private weak var informationLabel: UILabel!
  @IBOutlet private weak var triangleImageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    informationLabel.text = nil
    triangleImageView?.tintColor = UIColor.clear
    // Cancel previous download!!!
    avatarImageView.reset()
    accessoryType = AccessoryType.none
  }

  func present(event: GithubEventsScene.ListEvents.ViewModel.Event) {
    setInformationText(event.informationText)
    setAvatarImage(event.avatarUrl)
    setTriangleColor(event.color)
  }

  /// Change the main text of the cell
  /// - parameter text: text to set This parametr accept NSAttributedString
  func setInformationText(_ text: NSAttributedString) {
    informationLabel.attributedText = text
  }

  /// Change the upper right triangle color in cell
  /// - parameter color: Color to set
  func setTriangleColor(_ color: UIColor?) {
    if let view = triangleImageView {
      view.tintColor = color
    }
  }

  /// Show avatar image from user
  func setAvatarImage(_ urlStr: String) {
    avatarImageView.download(from: urlStr)
  }
}
