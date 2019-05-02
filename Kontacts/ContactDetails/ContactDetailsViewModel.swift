//
//  ContactDetailsViewModel.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import Foundation

protocol ContactDetailsViewDelegate: class {
  func showLoading(_ show: Bool)
  func reloadData()
  func contactDeleted()
  func contactEditted()
  func showApiError(for method: HttpMethod)
}

class ContactDetailsViewModel {
  let contactService: ContactService
  let contact: Contact
  var details: ContactDetails?
  weak var viewDelegate: ContactDetailsViewDelegate?

  init(
    _ contactService: ContactService,
    contact: Contact,
    viewDelegate: ContactDetailsViewDelegate
  ) {
    self.contactService = contactService
    self.contact = contact
    self.viewDelegate = viewDelegate
    fetchContactDetails()
  }

  func fetchContactDetails() {
    viewDelegate?.showLoading(true)
    DispatchQueue.global().async {
      ContactService.instance.getContactDetails(for: self.contact.id) { [weak self] response in
        DispatchQueue.main.async {
          guard let details = response else {
            self?.viewDelegate?.showLoading(false)
            self?.viewDelegate?.showApiError(for: .get)
            return
          }
          self?.details = details
          self?.viewDelegate?.reloadData()
          self?.viewDelegate?.showLoading(false)
        }
      }
    }
  }

  func deleteContact() {
    guard let details = details else { return }
    viewDelegate?.showLoading(true)
    DispatchQueue.global().async {
      ContactService.instance.deleteContact(contactId: details.id) { [weak self] response in
        DispatchQueue.main.async {
          if response {
            self?.viewDelegate?.contactDeleted()
          } else {
            self?.viewDelegate?.showApiError(for: .delete)
          }
          self?.viewDelegate?.showLoading(false)
        }
      }
    }
  }

  func favouriteClicked() {
    guard let details = details else { return }
    let updatedContactDetails = details.copy(isFavourite: !details.isFavourite)
    viewDelegate?.showLoading(true)
    DispatchQueue.global().async {
      ContactService.instance.updateContactDetails(updatedContactDetails, contactId: details.id) { [weak self] response in
        DispatchQueue.main.async {
          guard let details = response else {
            self?.viewDelegate?.showLoading(false)
            self?.viewDelegate?.showApiError(for: .put)
            return
          }
          self?.details = details
          self?.viewDelegate?.reloadData()
          self?.viewDelegate?.contactEditted()
          self?.viewDelegate?.showLoading(false)
        }
      }
    }
  }

  func getMailUrl() -> URL? {
    guard let details = details else { return nil }
    return URL(string: "mailto:\(details.email)")
  }

  func phoneCallUrl() -> URL? {
    guard let details = details else { return nil }
    return URL(string: "tel://\(details.phoneNumber)")
  }

  func getSmsUrl() -> URL? {
    guard let details = details else { return nil }
    return URL(string: "sms://\(details.phoneNumber)")
  }
}
