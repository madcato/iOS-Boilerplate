//
//  DetailViewController.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 29/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import UIKit

class DetailViewController: CDArchDetailViewController {
    @IBOutlet private weak var detailDescriptionLabel: UILabel!

    var event: Event? {
        detailItem as? Event
    }

    override func configureView() {
        // Update the user interface for the detail item
        detailDescriptionLabel?.text = event?.timestamp?.description
    }

    override func animateChange() {
        if detailDescriptionLabel.text != event?.timestamp?.description {
            UIView.transition(with: self.detailDescriptionLabel,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                self.detailDescriptionLabel.textColor = UIColor.purple.withAlphaComponent(0.7)
                self.detailDescriptionLabel.text = self.event?.timestamp?.description
            }, completion: { _ in
                UIView.transition(with: self.detailDescriptionLabel,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve) {
                    self.detailDescriptionLabel.textColor = UIColor.black
                }
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    // Code Test
    let backgroundManager = TestBackgroundChanger(mainDatabase: AppDelegate.shared.internalDatabase)

    @IBAction private func testChangeTapped(_ sender: Any) {
        guard let detailItem = self.detailItem else {
            return
        }
        backgroundManager.change(id: detailItem.objectID)
    }
}

import CoreData

/// This class is created to test a way to change a CoreData object and make
/// the DetailViewController to show that change automatiically, with an animation
class TestBackgroundChanger {
    let mainDatabase: CoreDataStack!
    lazy var database: CoreDataStack = {
        CoreDataStack(backgroundWithMaster: mainDatabase)
    }()

    init(mainDatabase: CoreDataStack) {
        self.mainDatabase = mainDatabase
    }

    func change(id: NSManagedObjectID) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let event = self?.database.getObject(byId: id) as? Event else {
                return
            }
            event.timestamp = Date()
            do {
                try event.managedObjectContext?.save()
            } catch {
                fatalError("Error saving item. \(error)")
            }
//            self?.database.saveContext()
        }
    }

    func createObject<T: NSManagedObject>() -> T {
        database.createObject()
    }

    func saveContext() {
        database.saveContext()
    }
}
