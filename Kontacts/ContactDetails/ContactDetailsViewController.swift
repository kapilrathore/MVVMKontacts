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

  override func viewDidLoad() {
    super.viewDidLoad()

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
    // TODO
  }

  @IBAction func favouriteButtonPress(_ sender: UIButton) {
    // TODO
  }

  @IBAction private func sendEmail() {
    // TODO
  }

  @IBAction private func makePhoneCall() {
    // TODO
  }

  @IBAction private func sendMessage() {
    // TODO
  }

  @IBAction private func deteleContact() {
    // TODO
  }
}
