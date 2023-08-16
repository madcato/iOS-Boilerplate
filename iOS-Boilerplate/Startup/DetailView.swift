//
//  DetailView.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 16/8/23.
//  Copyright © 2023 veladan. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let item: MarvelCharacter

    var body: some View {
        NavigationView {
            VStack {
                if let url = URL(string: item.thumbnailUrl ?? "") {
                    URLImage(url: url)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: UIScreen.main.bounds.height / 2)
                }
                Text(item.characterDescription ?? "")
                                .font(.body)
                                .padding()
                Spacer()
                Link(destination: URL(string: item.resourceUrl ?? "")!) {
                    Text("Detail")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle(item.name ?? "No name", displayMode: .large)
    }
}
