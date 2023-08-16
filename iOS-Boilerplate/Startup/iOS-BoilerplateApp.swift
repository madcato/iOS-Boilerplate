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
    let persistenceController = CoreDataStack(modelName: "iOS_Boilerplate")
    @State private var showingAlert = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.managedObjectContext)
                .onAppear {
                    Task {
                        do {
                            let downloader = MarvelDownloader(with: persistenceController, and: MarvelService())
                            try await downloader.downloadAndStoreCharacters()
                        } catch {
                            print(error)
                            showingAlert = true
                        }
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Important message"),
                          message: Text("Wear sunscreen"),
                          dismissButton: .default(Text("Got it!")))
                }
        }
    }
}


