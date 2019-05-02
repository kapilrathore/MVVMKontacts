//
//  UIView+Ext.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import UIKit

extension UIView {
  func addGradientLayer(topColor: UIColor, bottomColor: UIColor) {
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.colors = [
      topColor.cgColor,
      bottomColor.cgColor
    ]
    gradient.locations = [0.0 , 1.0]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
    gradient.frame = CGRect(
      x: 0.0,
      y: 0.0,
      width: self.frame.size.width,
      height: self.frame.size.height
    )
    self.layer.insertSublayer(gradient, at: 0)
  }
}
