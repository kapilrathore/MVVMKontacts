//
//  ContactDetailsViewController.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController, StoryboardLoadable, ReusableView {
  @IBOutlet private weak var topView: UIView!
  @IBOutlet private weak var avatarView: CustomImageView!
  @IBOutlet private weak var fullNameLabel: UILabel!
  @IBOutlet private weak var phoneNumberLabel: UILabel!
  @IBOutlet private weak var emailLabel: UILabel!
  @IBOutlet private weak var favouriteButton: UIButton!
  @IBOutlet private weak var loadingView: UIActivityIndicatorView!

  var contact: Contact!
  var viewModel: ContactDetailsViewModel!
  var dataChangeDelegate: DataChangeDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel = ContactDetailsViewModel(
      ContactService.instance,
      contact: contact,
      viewDelegate: self
    )
    setupUI()
  }

  private func setupUI() {
    setupClearNavigationBar()
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Edit",
      style: .plain,
      target: self,
      action: #selector(gotoEditContactScreen(_:))
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

  @objc private func gotoEditContactScreen(_ sender: UIBarButtonItem) {
    let contactDetailsScreen = AddEditContactViewController(from: AddEditContactViewController.reuseId)
    contactDetailsScreen.purpose = .edit
    contactDetailsScreen.contactDetails = viewModel.details
    contactDetailsScreen.dataChangeDelegate = self
    navigationController?.pushViewController(contactDetailsScreen, animated: true)
  }

  @IBAction func favouriteButtonPress(_ sender: UIButton) {
    viewModel.favouriteClicked()
  }

  @IBAction private func sendEmail() {
    guard let url = viewModel.getMailUrl() else { return }
    UIApplication.shared.open(url)
  }

  @IBAction private func makePhoneCall() {
    guard let url = viewModel.phoneCallUrl() else { return }
    UIApplication.shared.open(url)
  }

  @IBAction private func sendMessage() {
    guard let url = viewModel.getSmsUrl() else { return }
    UIApplication.shared.open(url)
  }

  @IBAction private func deteleContact() {
    showConfirmation("Do you want to delete this contact permanently?") { _ in
      self.viewModel.deleteContact()
    }
  }
}

extension ContactDetailsViewController: ContactDetailsViewDelegate {
  func showApiError(for method: HttpMethod) {
    showError(method.getErrorMessage())
  }

  func contactEditted() {
    self.dataChangeDelegate?.contactEdittedSuccessfully()
  }

  func showLoading(_ show: Bool) {
    show ? loadingView.startAnimating() : loadingView.stopAnimating()
  }

  func reloadData() {
    guard let details = viewModel.details else { return }

    fullNameLabel.text = details.fullName()

    let phoneNumber = details.phoneNumber.isEmpty ? "N/A" : details.phoneNumber
    phoneNumberLabel.text = phoneNumber

    let email = details.email.isEmpty ? "N/A" : details.email
    emailLabel.text = email

    let favImage = details.isFavourite ? #imageLiteral(resourceName: "favourite_button_selected") : #imageLiteral(resourceName: "favourite_button")
    favouriteButton.setImage(favImage, for: .normal)

    self.avatarView.loadImageFromUrl(details.avatarUrl)
  }

  func contactDeleted() {
    self.dataChangeDelegate?.contactDeletedSuccessfully()
    self.navigationController?.popViewController(animated: true)
  }
}

extension ContactDetailsViewController: DataChangeDelegate {
  func contactEdittedSuccessfully() {
    viewModel.fetchContactDetails()
    dataChangeDelegate?.contactEdittedSuccessfully()
  }
}

