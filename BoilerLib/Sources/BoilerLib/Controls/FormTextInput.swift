//
//  FormTextInput.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 23/8/23.
//  Copyright © 2023 veladan. All rights reserved.
//

import SwiftUI

public struct FormTextInput: View {
    public var label: String
    public var error: String
    @Binding public var text: String

    public init(label: String, error: String, text: Binding<String>) {
        self.label = label
        self.error = error
        self._text = text
    }

    public var body: some View {
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
