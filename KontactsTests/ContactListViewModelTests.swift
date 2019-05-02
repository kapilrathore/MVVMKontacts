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

  override func tearDown() {
    self.contactService = nil
    self.viewDelegate = nil
    self.viewModel = nil
  }
}

