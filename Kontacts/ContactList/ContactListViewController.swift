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

  override func viewDidLoad() {
    super.viewDidLoad()

    setupContactsTable()
  }

  private func setupContactsTable() {
    contactsTable.delegate = self
    contactsTable.dataSource = self
    contactsTable.rowHeight = 64
    self.contactsTable.separatorStyle = .none
  }

  @IBAction private func addNewContact(_ sender: UIBarButtonItem) {
  }
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return ""
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // TODO
    print("did select \(indexPath)")
  }

  func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    return ["a", "b"]
  }

  func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
    return 1
  }
}
