//
//  CoreDataStack.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 23/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import CoreData
import Foundation

class CoreDataStack: NSObject {

    init(modelName: String, testing: Bool = false) {
        assert(Thread.current.isMainThread == true) // Create this variable from the main thread
        self.managedObjectModel = NSManagedObjectModel()
        self.persistentStoreCoordinator = NSPersistentStoreCoordinator()
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        super.init()
        self.managedObjectModel = self.createObjectModel(modelName)
        self.persistentStoreCoordinator = self.createPersistentStore(modelName + ".sqlite", testing: testing)
        self.managedObjectContext = self.createObjectContext(self.persistentStoreCoordinator)
    }

    init(backgroundWithMaster database: CoreDataStack) {
        assert(Thread.current.isMainThread == false) // Create this variable from a background thread
        self.managedObjectModel = database.managedObjectModel
        self.persistentStoreCoordinator = database.persistentStoreCoordinator
        self.managedObjectContext = database.createObjectContextForPrivateThread()
    }

    private func createObjectModel(_ modelName: String) -> NSManagedObjectModel {
        // The managed object model for the application. This property is not optional.
        // It is a fatal error for the application not to be able to find and load its model.
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            NSLog("Model \(modelName).momd not found")
            abort()
        }
        guard let objectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            NSLog("Object model \(modelName).momd not created")
            abort()
        }
        return objectModel
    }

    private func createObjectContext(_ persistentStoreCoordinator: NSPersistentStoreCoordinator) ->
        NSManagedObjectContext {
            // Returns the managed object context for the application (which is already
            // bound to the persistent store coordinator for the application.) This property
            // is optional since there are legitimate error conditions that could cause
            // the creation of the context to fail.
            let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
            return managedObjectContext
    }

    private func createPersistentStore(_ fileName: String, testing: Bool) -> NSPersistentStoreCoordinator {
        if testing == true {
            return createInMemoryPersistentStore()
        } else {
            return createSQLitePersistentStore(fileName)
        }
    }

    private func createSQLitePersistentStore(_ fileName: String) -> NSPersistentStoreCoordinator {
        // The persistent store coordinator for the application. This implementation
        // creates and returns a coordinator, having added the store for the application
        // to it. This property is optional since there are legitimate error conditions
        // that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent(fileName)
        let failureReason = "There was an error creating or loading the application's saved data."
        let options = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true
        ]
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                               configurationName: nil,
                                               at: url,
                                               options: options)
        } catch let error as NSError {
            // Report any error we got.
            var dict = [String: Any]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as Any?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as Any?

            dict[NSUnderlyingErrorKey] = error
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate.
            // You should not use this function in a shipping application, although
            // it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        } catch {
            // dummy
        }
        return coordinator
    }

    private func createInMemoryPersistentStore() -> NSPersistentStoreCoordinator {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let failureReason = "There was an error creating or loading the application's saved data."
        let options = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true
        ]
        // Unit testing: store in memory
        do {
            try coordinator.addPersistentStore(ofType: NSInMemoryStoreType,
                                               configurationName: nil,
                                               at: nil,
                                               options: options)
        } catch let error as NSError {
            // Report any error we got.
            var dict = [String: Any]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as Any?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as Any?

            dict[NSUnderlyingErrorKey] = error
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate.
            // You should not use this function in a shipping application, although
            // it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }

    private func createObjectContextForPrivateThread() -> NSManagedObjectContext {
        let newManagedObjectContext = NSManagedObjectContext(concurrencyType:
            NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        newManagedObjectContext.performAndWait {
            newManagedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        }
        newManagedObjectContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return newManagedObjectContext
    }

    // MARK: - Core Data Stack

    private lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file.
        // This code uses a directory named "org.veladan.happic_ios" in the application's
        // documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count - 1]
    }()

    private var managedObjectModel: NSManagedObjectModel

    private var persistentStoreCoordinator: NSPersistentStoreCoordinator

    internal var managedObjectContext: NSManagedObjectContext

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application, although it
                // may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

    // MARK: - Core Data quering

    func getObjectFrom(_ entityName: String, _ wherePredicate: Where) -> NSManagedObject? {
        let fetchRequest = NSFetchRequest<NSManagedObject>()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext)
        assert(entity != nil)
        fetchRequest.entity = entity
        fetchRequest.fetchBatchSize = 20
        fetchRequest.predicate = wherePredicate.predicate

        do {
            let fetchedObjects = try self.managedObjectContext.fetch(fetchRequest)
            assert(fetchedObjects.count < 2) // Zero or only one are correct

            if fetchedObjects.isEmpty {
                return nil
            }

            return fetchedObjects[0]
        } catch let error as NSError {
            NSLog("Error getObjectFrom %@", error.localizedDescription)
            return nil
        }
    }

    func getResultsFrom(_ entityName: String,
                        _ sortBy: SortBy? = nil,
                        _ wherePredicate: Where? = nil) -> [Any] {
        let fetchRequest = NSFetchRequest<NSManagedObject>()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext)
        assert(entity != nil)
        fetchRequest.entity = entity
        fetchRequest.fetchBatchSize = 20
        if let sortBy = sortBy {
            fetchRequest.sortDescriptors = sortBy.sortDescriptors
        }
        if let wherePredicate = wherePredicate {
            fetchRequest.predicate = wherePredicate.predicate
        }

        do {
            let fetchedObjects = try self.managedObjectContext.fetch(fetchRequest)

            return fetchedObjects
        } catch let error as NSError {
            NSLog("Error getResultsFrom %@", error.localizedDescription)
            return []
        }
    }

    func createFetchedResultsController(_ entityName: String,
                                        _ sortBy: SortBy? = nil,
                                        _ wherePredicate: Where? = nil,
                                        sectionNameKeyPath: String?) ->
        NSFetchedResultsController<NSManagedObject>? {
            let fetchRequest = NSFetchRequest<NSManagedObject>()
            let entity = NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext)
            assert(entity != nil)
            fetchRequest.entity = entity
            fetchRequest.fetchBatchSize = 20
            if let sortBy = sortBy {
                fetchRequest.sortDescriptors = sortBy.sortDescriptors
            }
            if let wherePredicate = wherePredicate {
                fetchRequest.predicate = wherePredicate.predicate
            }
            // Edit the section name key path and cache name if appropriate.
            // nil for section name key path means "no sections".
            let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                       managedObjectContext: self.managedObjectContext,
                                                                       sectionNameKeyPath: sectionNameKeyPath,
                                                                       cacheName: nil)
            return aFetchedResultsController
    }

    func fetch(_ fetchedResultController: NSFetchedResultsController<NSManagedObject>) {
        do {
            try fetchedResultController.performFetch()
        } catch let error as NSError {
            NSLog("Error performFetch %@", error.localizedDescription)
        }
    }

    func createObject(_ entityName: String) -> NSManagedObject? {
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                                into: self.managedObjectContext)
        return managedObject
    }

    func deleteObjects(_ entityName: String, wherePredicate: Where? = nil) {
        let fetchRequest = NSFetchRequest<NSManagedObject>()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext)
        assert(entity != nil)
        fetchRequest.entity = entity
        if let wherePredicate = wherePredicate {
            fetchRequest.predicate = wherePredicate.predicate
        }

        do {
            let fetchedObjects = try self.managedObjectContext.fetch(fetchRequest)

            for object in fetchedObjects {
                self.managedObjectContext.delete(object)
            }
        } catch let error as NSError {
            NSLog("Error deleteObjects %@", error.localizedDescription)
        }
    }

    func delete(_ object: NSManagedObject) {
        self.managedObjectContext.delete(object)
    }

    func deleteAll(entities entityName: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.includesPropertyValues = false
        do {
            let fetchedObjects = try self.managedObjectContext.fetch(fetchRequest) as [NSManagedObject]
            for object in fetchedObjects {
                self.managedObjectContext.delete(object)
            }
            try self.managedObjectContext.save()
        } catch let error as NSError {
            NSLog("Error deleteAll %@", error.localizedDescription)
        }

    }

    func count(_ entityName: String) -> Int {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.includesPropertyValues = false
        do {
            let count = try self.managedObjectContext.count(for: request)
            if count == NSNotFound {
                NSLog("Unresolved error in count")
                return NSNotFound
            }
            return  count
        } catch let error as NSError {
            NSLog("Error deleteAll %@", error.localizedDescription)
        }
        return NSNotFound
    }
}

class Where {
    var predicate: NSPredicate

    init(predicate: String, arguments: [Any]?) {
        self.predicate = NSPredicate(format: predicate, argumentArray: arguments)
    }
}

class SortBy {
    var sortDescriptors: [NSSortDescriptor]

    // Sample:
    //  - SortBy(["year", "month"])
    //  - SortBy([{"sort": "year", ascending: false}, "month"])
    init(_ sortArray: [Any]) {
        self.sortDescriptors = SortBy.sortDescriptors(sortArray)
    }

    // Sample:
    //  - SortBy("year")
    init(_ sortBy: String) {
        self.sortDescriptors = SortBy.sortDescriptors([sortBy])
    }

    private static func sortDescriptors(_ sortArray: [Any]) -> [NSSortDescriptor] {
        var sortDescriptors = [NSSortDescriptor]()
        for element in sortArray {
            if element is String {
                let sortDescriptor = NSSortDescriptor(key: element as? String, ascending: true)
                sortDescriptors.append(sortDescriptor)
            }
            if let ele = element as? [String: Any],
                let ascending = ele["ascending"] as? Bool {
                let sortDescriptor = NSSortDescriptor(key: ele["sort"] as? String,
                                                      ascending: ascending)
                sortDescriptors.append(sortDescriptor)
            }
        }
        return sortDescriptors
    }
}
