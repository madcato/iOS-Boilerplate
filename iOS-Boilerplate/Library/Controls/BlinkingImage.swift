//
//  BlinkingImage.swift
//  Marla
//
//  Created by Daniel Vela on 22/03/2020.
//  Copyright © 2020 veladan. All rights reserved.
//

import UIKit

class BlinkingImage: UIImageView {
  override func awakeFromNib() {
      super.awakeFromNib()
    UIView.animate(withDuration: 1.2, delay: 0.0, options: [.autoreverse, .repeat, .curveEaseInOut]) {
      self.alpha = 0.10
    }
  }
}
