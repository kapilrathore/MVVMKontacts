//
//  DataChangeDelegate.swift
//  Kontacts
//
//  Created by Kapil Rathore on 02/05/19.
//  Copyright © 2019 me.kapilrathore. All rights reserved.
//

import Foundation

protocol DataChangeDelegate {
  func contactAddedSuccessfully()
  func contactEdittedSuccessfully()
  func contactDeletedSuccessfully()
}

extension DataChangeDelegate {
  func contactAddedSuccessfully() {}
  func contactEdittedSuccessfully() {}
  func contactDeletedSuccessfully() {}
}
