//
//  DataModel+Tests.swift
//  FitNessTests
//
//  Created by Artem Lytkin on 28/06/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import Foundation
@testable import FitNess

extension DataModel {
  func setToComplete() {
    goal = 100
    steps = 100
    distance = 1
  }
  
  func setToCaught() {
    goal = 100
    distance = 20
    nessie.distance = 40
  }
}
