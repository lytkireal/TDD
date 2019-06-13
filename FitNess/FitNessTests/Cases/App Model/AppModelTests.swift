//
//  AppModelTests.swift
//  FitNessTests
//
//  Created by Artem Lytkin on 13/06/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import XCTest
@testable import FitNess

class AppModelTest: XCTestCase {
  
  var sut: AppModel!
  
  override func setUp() {
    super.setUp()
    sut = AppModel()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testAppModel_whenInitialized_isInNotStartedState() {
    let state = sut.appState
    XCTAssertEqual(state, AppState.notStarted)
  }
  
  func testAppModel_whenStarted_isInProgressState() {
    // when
    sut.start()
    
    // then
    let state = sut.appState
    XCTAssertEqual(state, AppState.inProgress)
  }
}
