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
    let coreDataStack = CoreDataStack(modelName: "iOS_Boilerplate")
    @State private var showingAlert = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(coreDataStack)
                .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
                .onAppear {
                    Task {
                        do {
                            let downloader = MarvelDownloader(with: coreDataStack, and: MarvelService())
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
