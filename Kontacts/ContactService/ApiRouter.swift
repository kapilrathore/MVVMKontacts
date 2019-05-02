//
//  ApiRouter.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import Foundation

enum HttpMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"

  func getErrorMessage() -> String {
    var operation = ""
    switch self {
      case .get   : operation = "fetch"
      case .post  : operation = "add"
      case .put   : operation = "update"
      case .delete: operation = "delete"
    }

    return "Could not \(operation) contact. Please try again later."
  }
}

enum ApiRouter {
  case getAllContacts
  case getContactDetails(Int)
  case updateContact(Int, ContactDetails)

  private static let baseUrl = "http://gojek-contacts-app.herokuapp.com"

  var method: HttpMethod {
    switch self {
      case .getAllContacts        : return .get
      case .getContactDetails(_)  : return .get
      case .updateContact(_, _)   : return .put
    }
  }

  var endpoint: String {
    switch self {
      case .getAllContacts:
        return "/contacts.json"
      case .getContactDetails(let contactId):
        return "/contacts/\(contactId).json"
      case .updateContact(let contactId, _):
        return "/contacts/\(contactId).json"
    }
  }

  func request() -> URLRequest {
    let url = URL(string: ApiRouter.baseUrl + endpoint)!
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

    switch self {
      case .updateContact(_, let details):
        urlRequest.httpBody = try? JSONEncoder.init().encode(details)

      default: break
    }

    return urlRequest
  }
}
