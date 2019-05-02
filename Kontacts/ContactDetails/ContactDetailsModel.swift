//
//  ContactDetailsModel.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import Foundation

struct ContactDetails: Codable, Equatable {
  let id: Int
  let firstName: String
  let lastName: String
  let email: String
  let phoneNumber: String
  let avatarUrl: String
  let isFavourite: Bool
  let createdAt: String
  let updatedAt: String

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case firstName = "first_name"
    case lastName = "last_name"
    case email = "email"
    case phoneNumber = "phone_number"
    case avatarUrl = "profile_pic"
    case isFavourite = "favorite"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
  }

  func fullName() -> String {
    return "\(firstName) \(lastName)".capitalized
  }

  static func newContact() -> ContactDetails {
    return ContactDetails(
      id: -1,
      firstName: "",
      lastName: "",
      email: "",
      phoneNumber: "",
      avatarUrl: "",
      isFavourite: false,
      createdAt: "",
      updatedAt: ""
    )
  }

  func copy(
    firstName: String? = nil,
    lastName: String? = nil,
    email: String? = nil,
    phoneNumber: String? = nil,
    isFavourite: Bool? = nil
  ) -> ContactDetails {
    return ContactDetails(
      id: self.id,
      firstName: firstName ?? self.firstName,
      lastName: lastName ?? self.lastName,
      email: email ?? self.email,
      phoneNumber: phoneNumber ?? self.phoneNumber,
      avatarUrl: self.avatarUrl,
      isFavourite: isFavourite ?? self.isFavourite,
      createdAt: self.createdAt,
      updatedAt: self.updatedAt
    )
  }
}
