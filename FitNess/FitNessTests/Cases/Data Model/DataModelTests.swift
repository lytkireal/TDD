//
//  DataModelTests.swift
//  FitNessTests
//
//  Created by Artem Lytkin on 14/06/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import XCTest
@testable import FitNess

class DataModelTests: XCTestCase {

  var sut: DataModel!
  
  override func setUp() {
    super.setUp()
    sut = DataModel()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testModel_whenStepsReachGoal_goalIsReached() {
    // given
    sut.goal = 1000
    
    // when
    sut.steps = 1000
    
    // then
    XCTAssertTrue(sut.goalReached)
  }

  // MARK: - Goal
  
  func testModel_whenStarted_goalIsNotReached() {
    XCTAssertFalse(sut.goalReached, "goalReached should be false when the model is created")
  }
  
  func testGoal_whenUserCaught_cannotBeReached() {
    // given goal should be reached
    sut.goal = 1000
    sut.steps = 1000
    
    // when user caught
    sut.nessie.distance = 500
    sut.distance = 500
    
    // then
    XCTAssertFalse(sut.goalReached)
  }
  
  // MARK: - Nessie
  
  func testModel_whenStarted_userIsNotCaught() {
    XCTAssertFalse(sut.caught)
  }
  
  func testModel_whenUserAheadOfNessie_isNotCaught() {
    // given
    sut.distance = 400
    sut.nessie.distance = 57
    
    // then
    XCTAssertFalse(sut.caught)
  }
  
  func testModel_whenNessieAheadUser_isCaught() {
    // given
    sut.distance = 10
    sut.nessie.distance = 200
    
    // then
    XCTAssertTrue(sut.caught)
  }
}
