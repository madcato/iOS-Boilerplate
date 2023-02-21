//
//  CDArchTableViewController.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 14/2/23.
//  Copyright © 2023 veladan. All rights reserved.
//

import CoreData
import UIKit

class CDArchTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    lazy var database: CoreDataStack = {
        AppDelegate.database
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Fetched results controller
    func fetchedResultsController() -> NSFetchedResultsController<NSManagedObject> {
        fatalError("Override this method, and don't call super.fetchedResultsController()")
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
                          withData: anObject as? NSManagedObject)
            animateCell(tableView.cellForRow(at: indexPath),
                        withData: anObject as? NSManagedObject)
        case .move:
            guard let indexPath = indexPath,
                  let newIndexPath = newIndexPath else {
                return
            }
            configureCell(tableView.cellForRow(at: indexPath),
                          withData: anObject as? NSManagedObject)
            animateCell(tableView.cellForRow(at: indexPath),
                        withData: anObject as? NSManagedObject)
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
                let object = fetchedResultsController().object(at: indexPath)
                guard let controller = segue.destination as? CDArchDetailViewController else {
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
        fetchedResultsController().sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedResultsController().sections?[section] else {
            return 0
        }
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let event = fetchedResultsController().object(at: indexPath)
        configureCell(cell, withData: event)
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
            let context = fetchedResultsController().managedObjectContext
            context.delete(fetchedResultsController().object(at: indexPath))

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

    // MARK: Override this methods
    func configureCell(_ cell: UITableViewCell?, withData data: NSManagedObject?) { }

    func animateCell(_ cell: UITableViewCell?, withData data: NSManagedObject?) { }
}
