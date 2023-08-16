//
//  URLImage.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 16/8/23.
//  Copyright © 2023 veladan. All rights reserved.
//

import Combine
import SwiftUI

struct URLImage: View {
    @StateObject private var loader: ImageLoader

    init(url: URL) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
        } else {
            ProgressView() // show a progress view while the image is loading
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    var url: URL
    var cancellable: AnyCancellable?

    init(url: URL) {
        self.url = url
        load()
    }

    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    deinit {
        cancellable?.cancel()
    }
}
