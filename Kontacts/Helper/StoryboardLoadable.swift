//
//  StoryboardLoadable.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import UIKit

protocol StoryboardLoadable {}
extension StoryboardLoadable where Self: UIViewController {
  init(from identifier: String) {
    let controller = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: identifier)
    guard let viewController = controller as? Self else {
      fatalError("Could not initialize '\(identifier)'")
    }
    self = viewController
  }
}
