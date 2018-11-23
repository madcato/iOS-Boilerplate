//
//  Serializator.swift
//  TestPersistWebObject
//
//  Created by Daniel Vela on 04/07/16.
//  Copyright © 2016 Daniel Vela. All rights reserved.
//

import Foundation

//    class SerializableWebQuery: NSObject, NSCoding {
//        var url: String
//        
//        init(url: String) {
//            self.url = url
//        }
//        
//        required init?(coder aDecoder: NSCoder) {
//            self.url = aDecoder.decodeObject(forKey: "url") as! String
//        }
//        
//        func encode(with aCoder: NSCoder) {
//            aCoder.encode(self.url, forKey: "url")
//        }
//
//        func start(onOk: (), onError: ()) {
//            
//        }
//    }

//class SerializableWebQueries {
//
//    var fileName = "WebQueriesData"
//
//    var data: [SerializableWebQuery] = []
//
//    var running = false
//
//    func append(url: String, parameters: [NSObject:AnyObject]) {
//        self.data.append(SerializableWebQuery(url: url))
//
//        startContinue()
//    }
//
//    func appBecomeActive() {
//        let restoredObjects = Serializator().restoreObject(fileName: fileName)
//        if let restoredObjects = restoredObjects {
//            self.data = restoredObjects as! [SerializableWebQuery]
//        }
//        startContinue()
//    }
//
//    func appBecomeInactive() {
//        Serializator().saveObject(object: self.data, fileName: fileName)
//    }
//
//    func startContinue() {
//        if running == false {
//            running = true
//        }else {
//            return
//        }
//
//        sendAQuery()
//
//    }
//
//    static let initialSecondsToWaitOnError: Double = 5.0
//    var secondsToWaitOnError = {
//        initialSecondsToWaitOnError
//    }()
//
//    func sendAQuery() {
//        DispatchQueue.global(qos: .background).async {
//            if self.data.count > 0 {
//                let webQuery = self.data.removeFirst()
//
//                webQuery.start(onOk: {
//                    // Nothing. The query was ok
//                    // Continue with next one
//                    self.sendAQuery()
//                    self.secondsToWaitOnError = SerializableWebQueries.initialSecondsToWaitOnError
//                    }(), onError: {
//                        // On error the query must be restored on the queue
//                        DispatchQueue.global(qos: .background).async {
//                            self.data.append(webQuery)
//                            // and wait some seconds
//                            Thread.sleep(forTimeInterval: self.secondsToWaitOnError)
//                            self.secondsToWaitOnError *= 2
//                            self.sendAQuery()
//                        }
//                    }())
//            } else {
//                self.running = false
//            }
//        }
//    }
//}

//    func applicationWillResignActive(application: UIApplication) {
//  // Sent when the application is about to move from active to inactive state.
    //This can occur for certain types of temporary interruptions 
    // (such as an incoming phone call or SMS message) or when the user quits 
    // the application and it begins the transition to the background state.
//  // Use this method to pause ongoing tasks, disable timers, and throttle
    // down OpenGL ES frame rates. Games should use this method to pause the game.
//        Serializator().saveObject(self.data, fileName: "testData")
//    }
//
//    func applicationDidBecomeActive(application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while 
          // the application was inactive. If the application was previously 
          // in the background, optionally refresh the user interface.
//        
//        let restoredObjects = Serializator().restoreObject("testData")
//        if let restoredObjects = restoredObjects {
//            self.data = restoredObjects as! [SerializableWebQuery]
//        } 
//    }

/**
 Object serializator class
*/
class Serializator {

    init() {
    }
    /**
     Delete the serializator file for a class in the documents directory

     - Parameter fileName: Name of the file without directory part
     */
    func deleteSerial(fileName: String) {
        let formFilePath = self.formFilePath(className: fileName)
        do {
            try FileManager.default.removeItem(atPath: formFilePath)
        } catch let error as NSError {
            print("Error deleting file", fileName, error)
        }
    }

    /**
     Recreates an object from a serializaded object

     - Parameter fileName: Name of the file without directory part
    */
    func restoreObject(fileName: String) -> Any? {
        let formFilePath = self.formFilePath(className: fileName)
        let object = NSKeyedUnarchiver.unarchiveObject(withFile: formFilePath)
        return object as Any?
    }

    /**
     Saves an object.

     - Parameter object: This object must implement **NSCoding** class
     - Parameter fileName: Name of the file without directory part
    */
    func saveObject(object: Any, fileName: String) {
        let formFilePath = self.formFilePath(className: fileName)
        NSKeyedArchiver.archiveRootObject(object, toFile: formFilePath)
    }

    /**
     Constructs a complete path using the className as file name, document
     directory as base path and *.serial* as extension.

     - Parameter className: Name of the class to be used as file name
    */
    private func formFilePath(className: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                        FileManager.SearchPathDomainMask.userDomainMask,
                                                        true)
        let documentsDirectory = paths[0]
        let formFileName = "\(className).serial"
        let formFilePath = "\(documentsDirectory)/\(formFileName)"
        return formFilePath
    }
}
