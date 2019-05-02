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
  var dataChangeDelegate: DataChangeDelegate?

  var viewModel: AddEditContactViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel = AddEditContactViewModel(
      purpose: purpose,
      details: contactDetails,
      viewDelegate: self
    )
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
    switch textField {
      case firstNameField:
        viewModel.firstName = textField.text ?? ""
      case lastNameField:
        viewModel.lastName = textField.text ?? ""
      case emailField:
        viewModel.email = textField.text ?? ""
      case phoneNumberField:
        viewModel.phoneNumber = textField.text ?? ""
      default: break
    }
  }

  @objc func doneClick(_ sender: UIBarButtonItem) {
    self.view.endEditing(true)

    guard viewModel.isFormValid() else {
      return showError("All fields are required.")
    }

    switch viewModel.purpose {
    case .add : viewModel.addNewContact()
    case .edit: viewModel.editContact()
    }
  }

  @objc func cancelClick(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
}

extension AddEditContactViewController: AddEditContactViewDelegate {
  func showApiError(for method: HttpMethod) {
    showError(method.getErrorMessage())
  }

  func contactAddedSuccessfully() {
    self.dataChangeDelegate?.contactAddedSuccessfully()
    self.navigationController?.popViewController(animated: true)
  }

  func contactEdittedSuccessfully() {
    self.dataChangeDelegate?.contactEdittedSuccessfully()
    self.navigationController?.popViewController(animated: true)
  }

  func loadDetails(with details: ContactDetails) {
    firstNameField.text = details.firstName
    lastNameField.text = details.lastName
    phoneNumberField.text = details.phoneNumber
    emailField.text = details.email
  }

  func showLoadingView(_ show: Bool) {
    show ? loadingView.startAnimating() : loadingView.stopAnimating()
  }
}
