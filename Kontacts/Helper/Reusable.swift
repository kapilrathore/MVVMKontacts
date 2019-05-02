//
//  Reusable.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import UIKit

protocol ReusableView: class {
  static var reuseId: String { get }
}

extension ReusableView where Self: UIView {
  static var reuseId: String {
    return String(describing: self)
  }
}

extension ReusableView where Self: UIViewController {
  static var reuseId: String {
    return String(describing: self)
  }
}
