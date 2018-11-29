//
//  DetailViewController.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 29/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private weak var detailDescriptionLabel: UILabel!

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel,
               let timestamp = detail.timestamp {
                label.text = timestamp.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: Event? {
        didSet {
            // Update the view.
            configureView()
        }
    }
}
