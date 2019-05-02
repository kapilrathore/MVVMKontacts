//
//  AddEditContactViewModel.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import Foundation

protocol AddEditContactViewDelegate: class {
  func showLoadingView(_ show: Bool)
  func loadDetails(with details: ContactDetails)
  func contactAddedSuccessfully()
  func contactEdittedSuccessfully()
  func showApiError(for method: HttpMethod)
}

class AddEditContactViewModel {
  let purpose: Purpose
  let contactDetails: ContactDetails?
  private let contactService: ContactServiceProtocol
  weak var viewDelegate: AddEditContactViewDelegate?

  var firstName: String = ""
  var lastName: String = ""
  var email: String = ""
  var phoneNumber: String = ""

  init(
    purpose: Purpose,
    details: ContactDetails?,
    contactService: ContactServiceProtocol,
    viewDelegate: AddEditContactViewDelegate
  ) {
    self.purpose = purpose
    self.contactDetails = details
    self.contactService = contactService
    self.viewDelegate = viewDelegate

    if let validDetails = details {
      self.firstName = validDetails.firstName
      self.lastName = validDetails.lastName
      self.email = validDetails.email
      self.phoneNumber = validDetails.phoneNumber
      viewDelegate.loadDetails(with: validDetails)
    }
  }

  func isFormValid() -> Bool {
    guard !firstName.isEmpty else { return false }
    guard !lastName.isEmpty else { return false }
    guard !email.isEmpty else { return false }
    guard !phoneNumber.isEmpty else { return false }

    return true
  }

  func addNewContact() {
    self.viewDelegate?.showLoadingView(true)
    let updatedContactDetails = ContactDetails.newContact().copy(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber
    )
    DispatchQueue.global().async {
      self.contactService.addNewContact(updatedContactDetails) { [weak self] response in
        DispatchQueue.main.async {
          guard response != nil else {
            self?.viewDelegate?.showLoadingView(false)
            self?.viewDelegate?.showApiError(for: .post)
            return
          }
          self?.viewDelegate?.contactAddedSuccessfully()
          self?.viewDelegate?.showLoadingView(false)
        }
      }
    }
  }

  func editContact() {
    self.viewDelegate?.showLoadingView(true)
    let updatedContactDetails = contactDetails!.copy(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber
    )
    DispatchQueue.global().async {
      self.contactService.updateContactDetails(updatedContactDetails, contactId: updatedContactDetails.id) { [weak self] response in
        DispatchQueue.main.async {
          guard response != nil else {
            print("Error updating contact")
            self?.viewDelegate?.showLoadingView(false)
            self?.viewDelegate?.showApiError(for: .put)
            return
          }
          self?.viewDelegate?.contactEdittedSuccessfully()
          self?.viewDelegate?.showLoadingView(false)
        }
      }
    }
  }
}
