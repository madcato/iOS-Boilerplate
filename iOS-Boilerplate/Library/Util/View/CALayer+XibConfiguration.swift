//
//  CALayer+XibConfiguration.swift
//  OSFramework
//
//  Created by Daniel Vela on 13/06/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import QuartzCore
import UIKit

// Use thid class to indicate the color of the border from 
// Interface Builder in User Defined Runtime Attributes
// Create a new variable called: 'layer.borderUIColor' and
// set a Color variable type.
extension CALayer {
    func setBorderUIColor(color: UIColor) {
        self.borderColor = color.cgColor
    }
}
