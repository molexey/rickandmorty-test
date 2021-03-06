//
//  UIImageLoader.swift
//  rickandmorty-test
//
//  Created by molexey on 05.05.2022.
//

import Foundation
import UIKit

class UIImageLoader {
  static let loader = UIImageLoader()

  private let imageLoader = ImageLoader()
  private var uuidMap = [UIImageView: UUID]()

  private init() {}

    func load(_ url: URL, for imageView: UIImageView) {
      let token = imageLoader.loadImage(url) { result in
        defer { self.uuidMap.removeValue(forKey: imageView) }
        do {
          let image = try result.get()
          DispatchQueue.main.async {
            imageView.image = image
          }
        } catch {
          // Handle the error
        }
      }

      if let token = token {
        uuidMap[imageView] = token
      }
    }

    func cancel(for imageView: UIImageView) {
      if let uuid = uuidMap[imageView] {
        imageLoader.cancelLoad(uuid)
        uuidMap.removeValue(forKey: imageView)
      }
    }
}

extension UIImageView {
  func loadImage(at url: URL) {
    UIImageLoader.loader.load(url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
