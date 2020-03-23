//
//  BlinkingImage.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 23/03/2020.
//  Copyright © 2020 veladan. All rights reserved.
//

import UIKit

class BlinkingImage: UIImageView {
  override func awakeFromNib() {
    super.awakeFromNib()
    UIView.animate(withDuration: 1.2,
                   delay: 0.0,
                   options: [.autoreverse, .repeat, .curveEaseInOut],
                   animations: {
                    self.alpha = 0.10
    }, completion: nil)
  }
}
