//
//  MockContactService.swift
//  KontactsTests
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import Foundation
@testable import Kontacts

class MockContactService: ContactServiceProtocol {
  private init() { }
  static let instance = MockContactService()
  
  func getAllContacts(completion: @escaping ([Contact]?) -> ()) {
    completion(MockData.MockContact.allContacts)
  }

  func getContactDetails(for id: Int, completion: @escaping (ContactDetails?) -> ()) {
    let contactDetails = MockData.MockContactDetails.allContacts.first { $0.id == id }
    completion(contactDetails)
  }

  func updateContactDetails(_ details: ContactDetails, contactId: Int, completion: @escaping (ContactDetails?) -> ()) {
  }

  func deleteContact(contactId: Int, completion: @escaping (Bool) -> ()) {}

  func addNewContact(_ details: ContactDetails, completion: @escaping (ContactDetails?) -> ()) {}
}
