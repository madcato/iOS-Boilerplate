//
//  DownloadImageView.swift
//  GithubFeed
//
//  Created by Daniel Vela on 18/06/2019.
//  Copyright © 2019 veladan. All rights reserved.
//

import UIKit

/// Use this class to download an image form an url and present it
class DownloadImageView: UIImageView {
  private var downloadTask: URLSessionTask?
  private static var sessionWithCache: URLSession = {
    let config = URLSessionConfiguration.ephemeral
    return URLSession(configuration: config)
  }()

  /// Call this method to cancel previous download.
  /// - Attention: It's recomended to call this method from the **prepareForReuse** when using this method from an
  ///               **UITableViewCell**
  func reset() {
    downloadTask?.cancel()
    downloadTask = nil
    image = nil
  }

  /// Call this method to download an image from an url an shwo it in this UImageView
  /// - parameter from urlStr: URL string with the link to the image
  func download(from urlStr: String) {
    guard let url = URL(string: urlStr) else {
      return
    }
    downloadTask = self.downloadImage(url: url) { [weak self] image in
      self?.image = image
      self?.downloadTask = nil
    }
  }

  private func downloadImage(url: URL, onFinish: @escaping (UIImage?) -> Void) -> URLSessionTask {
    let downloadImageTask = DownloadImageView.sessionWithCache.dataTask(with: url) { data, _, _ in
      DispatchQueue.main.async {
        if let data = data {
          onFinish(UIImage(data: data))
        } else {
          onFinish(nil)
        }
      }
    }
    downloadImageTask.resume()
    return downloadImageTask
  }
}
