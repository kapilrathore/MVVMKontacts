//
//  MockData.swift
//  KontactsTests
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import Foundation
@testable import Kontacts

enum MockData {
  enum MockContact {
    static let amanContact = Contact(
      id: 101,
      firstName: "Aman",
      lastName: "Sharma",
      avatarUrl: "",
      isFavourite: true,
      url: "http://some-url-aman"
    )

    static let kapilContact = Contact(
      id: 102,
      firstName: "Kapil",
      lastName: "Rathore",
      avatarUrl: "",
      isFavourite: false,
      url: "http://some-url-kapil"
    )

    static let randomContact = Contact(
      id: 103,
      firstName: "Random",
      lastName: "Singh",
      avatarUrl: "",
      isFavourite: true,
      url: "http://some-url-random"
    )

    static let allContacts = [
      amanContact, kapilContact, randomContact
    ]
  }

  enum MockContactDetails {
    static let amanDetails = ContactDetails(
      id: MockContact.amanContact.id,
      firstName: MockContact.amanContact.firstName,
      lastName: MockContact.amanContact.lastName,
      email: "aman@mail.com",
      phoneNumber: "1234567890",
      avatarUrl: MockContact.amanContact.avatarUrl,
      isFavourite: MockContact.amanContact.isFavourite,
      createdAt: "",
      updatedAt: ""
    )
    static let kapilDetails = ContactDetails(
      id: MockContact.kapilContact.id,
      firstName: MockContact.kapilContact.firstName,
      lastName: MockContact.kapilContact.lastName,
      email: "kapil@mail.com",
      phoneNumber: "9876543210",
      avatarUrl: MockContact.kapilContact.avatarUrl,
      isFavourite: MockContact.kapilContact.isFavourite,
      createdAt: "",
      updatedAt: ""
    )
    static let randomDetails = ContactDetails(
      id: MockContact.randomContact.id,
      firstName: MockContact.randomContact.firstName,
      lastName: MockContact.randomContact.lastName,
      email: "random@mail.com",
      phoneNumber: "8976543210",
      avatarUrl: MockContact.randomContact.avatarUrl,
      isFavourite: MockContact.randomContact.isFavourite,
      createdAt: "",
      updatedAt: ""
    )

    static let allContacts = [
      amanDetails, kapilDetails, randomDetails
    ]
  }
}
