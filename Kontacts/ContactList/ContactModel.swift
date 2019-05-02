//
//  ContactModel.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import Foundation

struct Contact: Codable, Equatable {
  let id: Int
  let firstName: String
  let lastName: String
  let avatarUrl: String
  let isFavourite: Bool
  let url: String

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case firstName = "first_name"
    case lastName = "last_name"
    case avatarUrl = "profile_pic"
    case isFavourite = "favorite"
    case url = "url"
  }
}
