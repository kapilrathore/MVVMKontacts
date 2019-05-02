//
//  UIViewController+Ext.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import UIKit

extension UIViewController {
  func showError(_ message: String) {
    let alert = UIAlertController(
      title: "Error!",
      message: message,
      preferredStyle: .alert
    )
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(okAction)

    present(alert, animated: true, completion: nil)
  }

  func setupClearNavigationBar() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
  }
}
