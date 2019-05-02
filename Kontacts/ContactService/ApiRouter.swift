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
}

enum ApiRouter {
  case getAllContacts

  private static let baseUrl = "http://gojek-contacts-app.herokuapp.com"

  var method: HttpMethod {
    switch self {
      case .getAllContacts: return .get
    }
  }

  var endpoint: String {
    switch self {
      case .getAllContacts: return "/contacts.json"
    }
  }

  func request() -> URLRequest {
    let url = URL(string: ApiRouter.baseUrl + endpoint)!
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

    return urlRequest
  }
}
