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
}
