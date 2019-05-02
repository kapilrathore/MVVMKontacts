//
//  AddEditContactViewController.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import UIKit

enum Purpose {
  case add
  case edit
}

class AddEditContactViewController: UIViewController, StoryboardLoadable, ReusableView, UITextFieldDelegate {

  @IBOutlet private weak var topView: UIView!
  @IBOutlet private weak var firstNameField: UITextField!
  @IBOutlet private weak var lastNameField: UITextField!
  @IBOutlet private weak var phoneNumberField: UITextField!
  @IBOutlet private weak var emailField: UITextField!
  @IBOutlet private weak var loadingView: UIActivityIndicatorView!

  var purpose: Purpose = .add
  var contactDetails: ContactDetails?

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
  }

  private func setupUI() {
    setupClearNavigationBar()

    navigationItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .cancel,
      target: self,
      action: #selector(cancelClick(_:))
    )
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(doneClick(_:))
    )

    self.topView.addGradientLayer(
      topColor: UIColor.white,
      bottomColor: UIColor(
        red: 80.0/255,
        green: 227.0/255,
        blue: 194.0/255,
        alpha: 0.28
      )
    )
  }

  @IBAction func textFieldEditingDidChange(_ textField: UITextField) {
    // TODO - setup view model properties
  }

  @objc func doneClick(_ sender: UIBarButtonItem) {
    self.view.endEditing(true)
    // TODO
  }

  @objc func cancelClick(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
}

