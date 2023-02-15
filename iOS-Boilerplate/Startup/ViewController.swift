//
//  ViewController.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 21/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import CoreData
import UIKit

class ViewController: CDArchTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.accessibilityIdentifier = "EditButtonId"

        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(insertNewObject(_:)))
        addButton.accessibilityIdentifier = "AddButtonId"
        navigationItem.rightBarButtonItems?.append(addButton)
    }

    @IBAction private func loginButtonTapped(_ sender: UIBarButtonItem) {
        LoginRouter.showLogin(over: self)
    }

    @IBAction private func infoButtonPressed(_ sender: UIBarButtonItem) {
        InfoRouter.showInfo(over: self)
    }

    @objc
    func insertNewObject(_ sender: Any) {
        let newEvent = database.createObject() as Event
        newEvent.timestamp = Date()
        database.saveContext()
    }

    // MARK: - Fetched results controller
    private lazy var fetchedResultsControllerInternal: NSFetchedResultsController<Event> = {
        let controller = database.createFetchedResultsController(
            "Event",
            SortBy("timestamp")) as NSFetchedResultsController<Event>
        controller.delegate = self
        database.fetch(controller)
        return controller
    }()

    override func fetchedResultsController() -> NSFetchedResultsController<NSManagedObject> {
        guard let controller =
                self.fetchedResultsControllerInternal as? NSFetchedResultsController<NSManagedObject> else {
            fatalError("set value for property fetchedResultsControllerInternal")
        }
        return controller
    }

    // MARK: - Table View
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let event = fetchedResultsControllerInternal.object(at: indexPath)
        configureCell(cell, withEvent: event)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func configureCell(_ cell: UITableViewCell?, withData data: NSManagedObject?) {
        guard let event = data as? Event else {
            return
        }
        cell?.textLabel?.text = event.timestamp?.description
    }

    func configureCell(_ cell: UITableViewCell?, withEvent event: Event?) {
        cell?.textLabel?.text = event?.timestamp?.description
    }

    override func animateCell(_ cell: UITableViewCell?, withData data: NSManagedObject?) {
        if let textLabel = cell?.textLabel {
            UIView.transition(with: textLabel,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                textLabel.textColor = UIColor.purple.withAlphaComponent(0.7)
                if let event = data as? Event {
                    textLabel.text = event.timestamp?.description
                }
            }, completion: { _ in
                UIView.transition(with: textLabel,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve) {
                    textLabel.textColor = UIColor.black
                }
            })
        }
    }

    // test
    @IBAction private func startBackgroundInsertTapped(_ sender: Any) {
        let backgroundDatabase = TestBackgroundChanger(mainDatabase: AppDelegate.database)
        let event = fetchedResultsControllerInternal.object(at: IndexPath(row: 0, section: 0))
        let eventId = event.objectID
        DispatchQueue.global(qos: .background).async {
            for _ in 0...3 {
                let newEvent = backgroundDatabase.createObject() as Event
                newEvent.timestamp = Date()
                backgroundDatabase.saveContext()
                Thread.sleep(forTimeInterval: 3.0)
            }

            if let event = backgroundDatabase.database.getObject(byId: eventId) as? Event {
                event.timestamp = Date()
                backgroundDatabase.saveContext()
            }
        }
    }
}
