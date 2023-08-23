//
//  FormTextInput.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 23/8/23.
//  Copyright © 2023 veladan. All rights reserved.
//

import SwiftUI

struct FormTextInput: View {
    var label: String
    var error: String
    @Binding var text: String
    var body: some View {
        VStack {
            HStack {
                TextField(label, text: $text)
                Spacer()
                if !error.isEmpty {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                }
            }
        }
    }
}
