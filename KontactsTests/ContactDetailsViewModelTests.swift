//
//  ContactDetailsViewModelTests.swift
//  KontactsTests
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import XCTest
@testable import Kontacts

class ContactDetailsViewModelTests: XCTestCase {
  var viewModel: ContactDetailsViewModel!
  var contactService: ContactServiceProtocol!
  var contact: Contact!
  var contactDetails: ContactDetails!
  var viewDelegate: ContactDetailsViewDelegate!

  class MockContactDetailsView: ContactDetailsViewDelegate {
    func showLoading(_ show: Bool) {}
    func reloadData() {}
    func contactDeleted() {}
    func contactEditted() {}
    func showApiError(for method: HttpMethod) {}
  }

  override func setUp() {
    contactService = MockContactService.instance
    contact = MockData.MockContact.kapilContact
    contactDetails = MockData.MockContactDetails.kapilDetails
    viewDelegate = MockContactDetailsView()

    viewModel = ContactDetailsViewModel(
      contactService,
      contact: contact,
      viewDelegate: viewDelegate
    )
    viewModel.details = contactDetails
  }

  func test_fetchContacDetails() {
    viewModel.details = nil

    let expect = expectation(description: "Data loaded in view model after api call")

    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
      expect.fulfill()
    }

    waitForExpectations(timeout: 3) { _ in
      let actualValue = self.viewModel.details
      let expectedValue = MockData.MockContactDetails.kapilDetails

      XCTAssertEqual(expectedValue, actualValue)
    }
  }

  override func tearDown() {
    viewModel = nil
    contactService = nil
    contact = nil
    viewDelegate = nil
  }
}
