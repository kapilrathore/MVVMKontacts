//
//  ContactListCell.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import UIKit

class ContactListCell: UITableViewCell, ReusableView {

  @IBOutlet private weak var avatarView: CustomImageView!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var favouriteIcon: UIImageView!

  func configureCell(with contact: Contact) {
    nameLabel.text = contact.firstName + " " + contact.lastName
    favouriteIcon.isHidden = !contact.isFavourite
    avatarView.loadImageFromUrl(contact.avatarUrl)
  }
}
