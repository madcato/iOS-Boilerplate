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
    private var internalFetchedResultsController: NSFetchedResultsController<Event>?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
    }

    @objc
    func insertNewObject(_ sender: Any) {
        let context = self.fetchedResultsController.managedObjectContext
        let newEvent = Event(context: context)

        // If appropriate, configure the new managed object.
        newEvent.timestamp = Date()

        // Save the context.
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

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController<Event> {
        guard let controller = internalFetchedResultsController else {
            let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
            // Set the batch size to a suitable number.
            fetchRequest.fetchBatchSize = 20
            // Edit the sort key as appropriate.
            let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            let managedObjectContext = AppDelegate.shared.database.managedObjectContext
            // Edit the section name key path and cache name if appropriate.
            // nil for section name key path means "no sections".
            let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                       managedObjectContext: managedObjectContext,
                                                                       sectionNameKeyPath: nil,
                                                                       cacheName: "Master")
            aFetchedResultsController.delegate = self
            internalFetchedResultsController = aFetchedResultsController
            do {
                try aFetchedResultsController.performFetch()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application, although it
                // may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            return aFetchedResultsController
        }
        return controller
    }

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
        case .move:
            guard let indexPath = indexPath,
                  let newIndexPath = newIndexPath else {
                return
            }
            configureCell(tableView.cellForRow(at: indexPath),
                          withEvent: anObject as? Event)
            tableView.moveRow(at: indexPath, to: newIndexPath)
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
                guard let controller = (segue.destination as?
                    UINavigationController)?.topViewController as? DetailViewController else {
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
        return fetchedResultsController.sections?.count ?? 0
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

}
