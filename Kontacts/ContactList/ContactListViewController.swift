//
//  ContactListViewController.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {
  @IBOutlet private weak var contactsTable: UITableView!
  @IBOutlet private weak var loadingView: UIActivityIndicatorView!

  var viewModel: ContactListViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel = ContactListViewModel(
      ContactService.instance,
      viewDelegate: self
    )
    setupContactsTable()
  }

  private func setupContactsTable() {
    contactsTable.delegate = self
    contactsTable.dataSource = self
    contactsTable.rowHeight = 64
    self.contactsTable.separatorStyle = .none
  }

  @IBAction private func addNewContact(_ sender: UIBarButtonItem) {
    gotoAddContactScreen()
  }

  func gotoContactDetailsScreen(_ contact: Contact) {
    let contactDetailsScreen = ContactDetailsViewController(from: ContactDetailsViewController.reuseId)
    contactDetailsScreen.contact = contact
    contactDetailsScreen.dataChangeDelegate = self
    navigationController?.pushViewController(contactDetailsScreen, animated: true)
  }

  func gotoAddContactScreen() {
    let addContactScreen = AddEditContactViewController(from: AddEditContactViewController.reuseId)
    addContactScreen.purpose = .add
    addContactScreen.dataChangeDelegate = self
    navigationController?.pushViewController(addContactScreen, animated: true)
  }
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections()
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return viewModel.titleForHeader(in: section)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRow(in: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactListCell.reuseId, for: indexPath) as? ContactListCell else {
      return UITableViewCell()
    }

    if let contact = viewModel.item(for: indexPath) {
      cell.configureCell(with: contact)
    }
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let contact = viewModel.item(for: indexPath) {
      gotoContactDetailsScreen(contact)
    }
  }

  func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    return viewModel.sectionIndexTitles()
  }

  func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
    return viewModel.section(for: title)
  }
}

extension ContactListViewController: ContactListViewDelegate {
  func showApiError(for method: HttpMethod) {
    showError(method.getErrorMessage())
  }

  func reloadData() {
    let dataPresent = viewModel.numberOfSections() > 0
    contactsTable.separatorStyle = dataPresent ? .singleLine : .none
    contactsTable.reloadData()
  }

  func showLoadingView(_ show: Bool) {
    show ? loadingView.startAnimating() : loadingView.stopAnimating()
  }
}

extension ContactListViewController: DataChangeDelegate {
  func contactAddedSuccessfully() {
    viewModel.fetchAllContacts()
  }
  
  func contactEdittedSuccessfully() {
    viewModel.fetchAllContacts()
  }

  func contactDeletedSuccessfully() {
    viewModel.fetchAllContacts()
  }
}
