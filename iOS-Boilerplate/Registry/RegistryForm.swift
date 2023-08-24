//
//  RegistryForm.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 23/8/23.
//  Copyright © 2023 veladan. All rights reserved.
//

import CoreData
import SwiftUI

struct RegistryForm: View {
    @EnvironmentObject var coreDataStack: CoreDataStack
    @StateObject var user: User
    @State var name: String = ""
    @State var surname: String = ""
    @State var email: String = ""
    @State var dni: String = ""
    @State var showAlert = false
    @State var alertText = ""
    @State var nameError = ""
    @State var surnameError = ""
    @State var emailError = ""
    @State var dniError = ""
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    var body: some View {
            NavigationView {
                Form {
                    FormTextInput(label: "Name", error: nameError, text: $name)
                    FormTextInput(label: "Surname", error: surnameError, text: $surname)
                    FormTextInput(label: "Email", error: emailError, text: $email)
                    FormTextInput(label: "DNI", error: dniError, text: $dni)
                        .onChange(of: dni) { newValue in
                            dni = newValue.uppercased()
                        }
                }
                .navigationBarTitle("Edit User")
                .navigationBarItems(leading: Button(action: {
                    if hasChanges() {
                        alertText = "Are you sure you want to cancel changes?"
                        showAlert = true
                    } else {
                        dismiss()
                    }
                }, label: {
                    Text("Cancel")
                }),
                                                    trailing: Button(action: {
                    if validateFields() {
                        saveUser()
                        dismiss()
                    }
                }, label: {
                    Text("Save")
                }))
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertText),
                      primaryButton: .cancel(Text("Return")) {
                          showAlert = false
                      }, secondaryButton: .destructive(Text("Discard changes")) {
                          dismiss()
                      })
            }
            .onAppear {
            loadData()
            }
        }

    func loadData() {
        name = user.name ?? ""
        surname = user.surname ?? ""
        email = user.email ?? ""
        dni = user.dni ?? ""
    }

    func hasChanges() -> Bool {
        name != (user.name ?? "") ||
        surname != (user.surname ?? "") ||
        email != (user.email ?? "") ||
        dni != (user.dni ?? "")
    }

    func saveUser() {
        user.name = name
        user.surname = surname
        user.email = email
        user.dni = dni
        coreDataStack.saveContext()
    }

    func validateFields() -> Bool {
        nameError = name.isEmpty ? "Name is required" : ""
        surnameError = surname.isEmpty ? "Surname is required" : ""
        emailError = email.isEmpty ? "Email is required" : ""
        dniError = dni.isEmpty ? "DNI is required" : ""

        guard !name.isEmpty, !surname.isEmpty, !email.isEmpty, !dni.isEmpty else {
            return false
        }

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if !emailTest.evaluate(with: email) {
            emailError = "Please enter a valid email"
            return false
        }

        let dniRegex = "(^([0-9]{8}[A-Z])|([XYZ][0-9]{7}[A-Z])$)"
        let dniTest = NSPredicate(format: "SELF MATCHES %@", dniRegex)
        if !dniTest.evaluate(with: dni) {
            dniError = "Please enter a valid DNI/NIE"
            return false
        } else {
            let letterArray = "TRWAGMYFPDXBNJZSQVHLCKE"
            var nieNumber = String(dni.dropFirst().prefix(7))
            let initialLetter = dni.prefix(1)

            switch initialLetter {
            case "X":
                nieNumber = "0" + nieNumber
            case "Y":
                nieNumber = "1" + nieNumber
            case "Z":
                nieNumber = "2" + nieNumber
            default:
                nieNumber = initialLetter + nieNumber
            }

            let position = Int(nieNumber)! % 23
            let expectedLetter = String(letterArray[letterArray.index(letterArray.startIndex, offsetBy: position)])
            let receivedLetter = String(dni.suffix(1))

            if expectedLetter == receivedLetter {
                return true
            } else {
                dniError = "Please enter a correct DNI/NIE"
                return false
            }
        }
    }

    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}
