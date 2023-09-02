//
//  UserList.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 24/8/23.
//  Copyright © 2023 veladan. All rights reserved.
//

import BoilerLib
import SwiftUI

struct UserList: View {
    @EnvironmentObject var coreDataStack: CoreDataStack
    @FetchRequest(entity: User.entity(), sortDescriptors: [])
    var users: FetchedResults<User>

    @State var selectedUser: User?
    @State private var presentView = false

    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    HStack {
                        Text("\(user.name ?? "") \(user.surname ?? "")")
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedUser = user
                        presentView = true
                    }
                }
                .onDelete(perform: deleteUser)
            }
            .navigationBarTitle("Users", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: { Text("Close") })
                , trailing: Button(action: {
                selectedUser = User.create(in: coreDataStack)!
                presentView = true
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $presentView) {
                RegistryForm(user: $selectedUser)
            }
        }
    }

    func deleteUser(at offsets: IndexSet) {
        offsets.forEach { index in
            let user = users[index]
            coreDataStack.delete(user)
        }
        coreDataStack.saveContext()
    }
}
