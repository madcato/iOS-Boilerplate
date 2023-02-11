//
//  ViewController.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 21/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import CoreData
import UIKit

class ViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    var detailViewController: DetailViewController?
    lazy var database: CoreDataStack = {
        AppDelegate.database
    }()

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

    lazy var fetchedResultsController: NSFetchedResultsController<Event> = {
        let controller = database.createFetchedResultsController(
            "Event",
            SortBy("timestamp")) as NSFetchedResultsController<Event>
        controller.delegate = self
        database.fetch(controller)
        return controller
    }()

    func controllerWillChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {
                return
            }
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath else {
                return
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update:
            guard let indexPath = indexPath else {
                return
            }
            configureCell(tableView.cellForRow(at: indexPath),
                          withEvent: anObject as? Event)
            animateCell(tableView.cellForRow(at: indexPath),
                        withEvent: anObject as? Event)
        case .move:
            guard let indexPath = indexPath,
                  let newIndexPath = newIndexPath else {
                return
            }
            configureCell(tableView.cellForRow(at: indexPath),
                          withEvent: anObject as? Event)
            animateCell(tableView.cellForRow(at: indexPath),
                        withEvent: anObject as? Event)
            tableView.moveRow(at: indexPath, to: newIndexPath)
        @unknown default:
            fatalError("Uknown case value for enum NSFetchedResultsChangeType")
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = fetchedResultsController.object(at: indexPath)
                guard let controller = segue.destination as? DetailViewController else {
                        return
                    }
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedResultsController.sections?[section] else {
            return 0
        }
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let event = fetchedResultsController.object(at: indexPath)
        configureCell(cell, withEvent: event)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchedResultsController.managedObjectContext
            context.delete(fetchedResultsController.object(at: indexPath))

            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application, although it may
                // be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func configureCell(_ cell: UITableViewCell?, withEvent event: Event?) {
        cell?.textLabel?.text = event?.timestamp?.description
    }

    func animateCell(_ cell: UITableViewCell?, withEvent event: Event?) {
        if let textLabel = cell?.textLabel {
            UIView.transition(with: textLabel,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                textLabel.textColor = UIColor.purple.withAlphaComponent(0.7)
                textLabel.text = event?.timestamp?.description
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
        let event = fetchedResultsController.object(at: IndexPath(row: 0, section: 0))
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
