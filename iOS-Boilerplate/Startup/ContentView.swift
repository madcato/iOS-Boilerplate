//
//  ContentView.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 17/4/23.
//  Copyright © 2023 veladan. All rights reserved.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext)
    private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MarvelCharacter.marvelId, ascending: true)],
        animation: .default)
    private var items: FetchedResults<MarvelCharacter>  // swiftlint:disable:this let_var_whitespace

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items) { item in
                        NavigationLink(destination: DetailView(item: item)) {
                            HStack {
                                if let url = URL(string: item.thumbnailUrl ?? "") {
                                    URLImage(url: url)
                                        .border(Color.black, width: 2)
                                        .cornerRadius(10.0)
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                }
                                Text(item.name ?? "No name")
                            }
                        }
                    }
                }
                Spacer()
                Text("Data provided by Marvel. © 2023 MARVEL")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding()
            }
            .navigationBarTitle("Marvel Characters", displayMode: .large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
