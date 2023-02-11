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
        // Update the user interface for the detail item
        detailDescriptionLabel?.text = detailItem?.timestamp?.description
    }

    func animateChange() {
        if detailDescriptionLabel.text != detailItem?.timestamp?.description {
            UIView.transition(with: self.detailDescriptionLabel,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                self.detailDescriptionLabel.textColor = UIColor.purple.withAlphaComponent(0.7)
                self.detailDescriptionLabel.text = self.detailItem?.timestamp?.description
            }, completion: { _ in
                UIView.transition(with: self.detailDescriptionLabel,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve) {
                    self.detailDescriptionLabel.textColor = UIColor.black
                }
            })
        }
    }

    func configureNotification() {
        if let detail = detailItem {
            NotificationCenter.default.addObserver(forName: Notification.Name.NSManagedObjectContextDidSave,
                                                   object: nil,
                                                   queue: nil) { [weak self] notif in
                if let setObjects = notif.userInfo?[NSUpdatedObjectsKey] as? Set<Event>,
                   setObjects.first?.objectID == detail.objectID {
                    DispatchQueue.main.async {
                        self?.animateChange()
                    }
                }
            }
        }
    }

    deinit {
        if let detail = detailItem {
            NotificationCenter.default.removeObserver(self,
                                                      name: Notification.Name.NSManagedObjectContextDidSave,
                                                      object: detail.managedObjectContext)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: Event? {
        didSet {
            configureView()
            configureNotification()
        }
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
            self?.database.saveContext()
        }
    }

    func createObject<T: NSManagedObject>() -> T {
        database.createObject()
    }

    func saveContext() {
        database.saveContext()
    }
}
