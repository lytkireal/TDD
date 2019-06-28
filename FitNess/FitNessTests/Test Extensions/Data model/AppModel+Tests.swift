//
//  AppModel+Tests.swift
//  FitNessTests
//
//  Created by Artem Lytkin on 28/06/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import Foundation
@testable import FitNess

extension AppModel {
  func setToComplete() {
    dataModel.setToComplete()
    try! setCompleted()
  }
  
  func setToCaught() {
    dataModel.setToCaught()
    try! setCaught()
  }
}
