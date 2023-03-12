//
//  CDArchDetailViewController.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 14/2/23.
//  Copyright © 2023 veladan. All rights reserved.
//

import CoreData
import UIKit

class CDArchDetailViewController: UIViewController {

    var detailItem: NSManagedObject? {
        didSet {
            configureView()
            configureNotification()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        do {
            try detailItem?.managedObjectContext?.save()
        } catch {
            fatalError("Error saving item. \(error)")
        }
    }
    private func configureNotification() {
        if let detail = detailItem {
            NotificationCenter.default.addObserver(forName: Notification.Name.NSManagedObjectContextDidSave,
                                                   object: nil,
                                                   queue: nil) { [weak self] notif in
                if let setObjects = notif.userInfo?[NSUpdatedObjectsKey] as? Set<NSManagedObject>,
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

    // MARK: Override this methods
    func configureView() { }

    func animateChange() { }
}
