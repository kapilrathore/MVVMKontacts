//
//  ContactListViewModel.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import Foundation

protocol ContactListViewDelegate: class {
  func reloadData()
  func showLoadingView(_ show: Bool)
  func showApiError(for method: HttpMethod)
}

class ContactListViewModel {
  private let contactService: ContactServiceProtocol
  private weak var viewDelegate: ContactListViewDelegate?

  var contactsDictionary = [String: [Contact]]()
  var contactSectionTitles = [String]()

  init(_ contactService: ContactServiceProtocol, viewDelegate: ContactListViewDelegate) {
    self.contactService = contactService
    self.viewDelegate = viewDelegate
    fetchAllContacts()
  }

  func fetchAllContacts() {
    viewDelegate?.showLoadingView(true)
    DispatchQueue.global().async {
      self.contactService.getAllContacts { [weak self] response in
        DispatchQueue.main.async {
          guard let contacts = response,
          let contactsDict = self?.getContactsDictionary(from: contacts) else {
            self?.viewDelegate?.showLoadingView(false)
            self?.viewDelegate?.showApiError(for: .get)
            return
          }

          self?.contactsDictionary = contactsDict
          self?.contactSectionTitles = contactsDict.keys.sorted()
          self?.viewDelegate?.reloadData()
          self?.viewDelegate?.showLoadingView(false)
        }
      }
    }
  }

  func getContactsDictionary(from contacts: [Contact]) -> [String: [Contact]] {
    var contactsDict = [String: [Contact]]()

    for contact in contacts {
      let firstAlpha = String(contact.firstName.first!).uppercased()
      if var contactValues = contactsDict[firstAlpha] {
        contactValues.append(contact)
        contactsDict[firstAlpha] = contactValues
      } else {
        contactsDict[firstAlpha] = [contact]
      }
    }

    return contactsDict
  }

  func numberOfSections() -> Int {
    return contactSectionTitles.count
  }

  func titleForHeader(in section: Int) -> String {
    return contactSectionTitles[section]
  }

  func numberOfRow(in section: Int) -> Int {
    let key = contactSectionTitles[section]
    guard let contacts = contactsDictionary[key] else { return 0 }
    return contacts.count
  }

  func item(for indexPath: IndexPath) -> Contact? {
    let key = contactSectionTitles[indexPath.section]
    guard let contacts = contactsDictionary[key] else { return nil }
    return contacts[indexPath.row]
  }

  func sectionIndexTitles() -> [String] {
    return contactSectionTitles
  }

  func section(for title: String) -> Int {
    guard let index = contactSectionTitles.index(of: title) else { return -1 }
    return index
  }
}
