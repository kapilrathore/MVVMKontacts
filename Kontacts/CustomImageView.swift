//
//  CustomImageView.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
  var imageUrlString: String?

  func loadImageFromUrl(_ urlString: String) {

    self.clipsToBounds = true
    self.layer.cornerRadius = self.frame.height/2
    self.layer.borderColor = UIColor.white.cgColor
    self.layer.borderWidth = 2


    self.image = UIImage(named: "placeholder_photo")

    guard urlString != "/images/missing.png",
      let imageUrl = URL(string: urlString) else { return }

    imageUrlString = urlString

    if let cachedImage = imageCache.object(forKey: urlString as NSString) {
      self.image = cachedImage
      return
    }

    DispatchQueue.global().async {
      guard let imageData = try? Data(contentsOf: imageUrl) else { return }
      DispatchQueue.main.async {
        guard let downloadedImage = UIImage(data: imageData) else { return }

        if let imageLink = self.imageUrlString, imageLink == urlString {
          self.image = downloadedImage
        }

        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
      }
    }
  }
}

