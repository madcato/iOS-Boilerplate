//
//  iOS-BoilerplateApp.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 17/4/23.
//  Copyright © 2023 veladan. All rights reserved.
//

import SwiftUI

@main
struct MainiOSBoilerplateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
