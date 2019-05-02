//
//  ContactServiceProtocol.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import Foundation

protocol ContactServiceProtocol {
  func getAllContacts(completion: @escaping ([Contact]?) -> ())
  func getContactDetails(for id: Int, completion: @escaping (ContactDetails?) -> ())
  func updateContactDetails(_ details: ContactDetails, contactId: Int, completion: @escaping (ContactDetails?) -> ())
  func deleteContact(contactId: Int, completion: @escaping (Bool) -> ())
  func addNewContact(_ details: ContactDetails, completion: @escaping (ContactDetails?) -> ())
}
