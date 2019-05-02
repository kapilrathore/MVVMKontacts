//
//  AddEditViewModelTests.swift
//  KontactsTests
//
//  Created by Kapil Rathore on 03/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import XCTest
@testable import Kontacts

class AddEditViewModelTests: XCTestCase {
  var viewModel: AddEditContactViewModel!
  var contactService: ContactServiceProtocol!
  var viewDelegate: AddEditContactViewDelegate!

  class MockAddEditContactView: AddEditContactViewDelegate {
    func showLoadingView(_ show: Bool) {}
    func loadDetails(with details: ContactDetails) {}
    func contactAddedSuccessfully() {}
    func contactEdittedSuccessfully() {}
    func showApiError(for method: HttpMethod) {}
  }

  override func setUp() {
    contactService = MockContactService.instance
    viewDelegate = MockAddEditContactView()
  }

  private func initViewModel(with details: ContactDetails?) {
    viewModel = AddEditContactViewModel(
      purpose: .add,
      details: details,
      contactService: contactService,
      viewDelegate: viewDelegate
    )
  }

  func test_properties_setup_correctly_for_valid_details() {
    let details: ContactDetails? = nil
    initViewModel(with: details)
    XCTAssertEqual("", viewModel.firstName)
    XCTAssertEqual("", viewModel.lastName)
    XCTAssertEqual("", viewModel.phoneNumber)
    XCTAssertEqual("", viewModel.email)

    let validDetails = MockData.MockContactDetails.kapilDetails
    initViewModel(with: validDetails)
    XCTAssertEqual(validDetails.firstName, viewModel.firstName)
    XCTAssertEqual(validDetails.lastName, viewModel.lastName)
    XCTAssertEqual(validDetails.phoneNumber, viewModel.phoneNumber)
    XCTAssertEqual(validDetails.email, viewModel.email)
  }

  func test_isFormValid() {
    let details: ContactDetails? = nil
    initViewModel(with: details)
    XCTAssertEqual(viewModel.isFormValid(), false)

    let validDetails = MockData.MockContactDetails.kapilDetails
    initViewModel(with: validDetails)
    XCTAssertEqual(viewModel.isFormValid(), true)
  }

  override func tearDown() {
    viewModel = nil
    contactService = nil
    viewDelegate = nil
  }
}
