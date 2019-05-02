//
//  ContactListViewModelTests.swift
//  KontactsTests
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import XCTest
@testable import Kontacts

class ContactListViewModelTests: XCTestCase {

  var contactService: ContactServiceProtocol!
  var viewDelegate: ContactListViewDelegate!
  var viewModel: ContactListViewModel!

  class MockContactListView: ContactListViewDelegate {
    func reloadData() {}
    func showLoadingView(_ show: Bool) {}
    func showApiError(for method: HttpMethod) {}
  }

  override func setUp() {
    contactService = MockContactService.instance
    viewDelegate = MockContactListView()
    viewModel = ContactListViewModel(contactService, viewDelegate: viewDelegate)
    viewModel.contactsDictionary = MockData.contactDictionary
    viewModel.contactSectionTitles = MockData.contactSectionTitles
  }

  func test_data_loaded_correctly_after_successful_api_call() {
    viewModel.contactsDictionary = [:]
    viewModel.contactSectionTitles = []

    let expect = expectation(description: "Data loaded in view model after api call")

    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
      expect.fulfill()
    }

    waitForExpectations(timeout: 2) { _ in
      let actualValue = self.viewModel.contactsDictionary
      let expectedValue = MockData.contactDictionary

      XCTAssertEqual(expectedValue, actualValue)
    }
  }

  func test_getContactsDictionary() {
    let actualValue = viewModel.contactsDictionary
    let expectedValue = MockData.contactDictionary

    XCTAssertEqual(expectedValue, actualValue)
  }

  func test_numberOfSections() {
    let actualValue = viewModel.contactSectionTitles.count
    let expectedValue = 3

    XCTAssertEqual(expectedValue, actualValue)
  }

  func test_titleForHeader() {
    let actualValue_0 = viewModel.contactSectionTitles[0]
    let expectedValue_0 = "A"
    XCTAssertEqual(expectedValue_0, actualValue_0)

    let actualValue_1 = viewModel.contactSectionTitles[1]
    let expectedValue_1 = "K"
    XCTAssertEqual(expectedValue_1, actualValue_1)

    let actualValue_2 = viewModel.contactSectionTitles[2]
    let expectedValue_2 = "R"
    XCTAssertEqual(expectedValue_2, actualValue_2)
  }

  func test_numberOfRow() {
    let expectedValue = 1

    let actualValue_0 = viewModel.numberOfRow(in: 0)
    XCTAssertEqual(expectedValue, actualValue_0)

    let actualValue_1 = viewModel.numberOfRow(in: 1)
    XCTAssertEqual(expectedValue, actualValue_1)

    let actualValue_2 = viewModel.numberOfRow(in: 2)
    XCTAssertEqual(expectedValue, actualValue_2)
  }

  override func tearDown() {
    self.contactService = nil
    self.viewDelegate = nil
    self.viewModel = nil
  }
}

