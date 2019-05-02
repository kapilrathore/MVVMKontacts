//
//  ContactService.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import Foundation

class ContactService {
  private init() {}
  static let instance = ContactService()
  private let session = URLSession.shared

  func getAllContacts(completion: @escaping ([Contact]?) -> ()) {
    let urlRequest = ApiRouter.getAllContacts.request()

    session.dataTask(with: urlRequest) {
      (data, response, error) in

      guard let data = data else { return completion(nil) }
      let contacts = try? JSONDecoder().decode([Contact].self, from: data)

      completion(contacts)
    }.resume()
  }

  func getContactDetails(for id: Int, completion: @escaping (ContactDetails?) -> ()) {
    let urlRequest = ApiRouter.getContactDetails(id).request()

    session.dataTask(with: urlRequest) {
      (data, response, error) in

      guard let data = data else { return completion(nil) }
      let contactDetails = try? JSONDecoder().decode(ContactDetails.self, from: data)

      completion(contactDetails)
    }.resume()
  }

  func updateContactDetails(_ details: ContactDetails, contactId: Int, completion: @escaping (ContactDetails?) -> ()) {
    let urlRequest = ApiRouter.updateContact(contactId, details).request()

    session.dataTask(with: urlRequest) {
      (data, response, error) in

      guard let data = data else { return completion(nil) }
      let contactDetails = try? JSONDecoder().decode(ContactDetails.self, from: data)

      completion(contactDetails)
    }.resume()
  }

  func deleteContact(contactId: Int, completion: @escaping (Bool) -> ()) {
    let urlRequest = ApiRouter.deleteCotnact(contactId).request()

    session.dataTask(with: urlRequest) {
      (data, response, error) in

      completion(error == nil)
    }.resume()
  }

  func addNewContact(_ details: ContactDetails, completion: @escaping (ContactDetails?) -> ()) {
    let urlRequest = ApiRouter.addNewContact(details).request()

    session.dataTask(with: urlRequest) {
      (data, response, error) in

      guard let data = data else { return completion(nil) }
      let contactDetails = try? JSONDecoder().decode(ContactDetails.self, from: data)

      completion(contactDetails)
    }.resume()
  }
}
