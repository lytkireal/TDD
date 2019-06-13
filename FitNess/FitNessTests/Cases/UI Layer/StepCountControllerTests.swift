//
//  StepCountControllerTests.swift
//  FitNessTests
//
//  Created by Artem Lytkin on 13/06/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import XCTest
@testable import FitNess

class StepCountControllerTests: XCTestCase {
  
  var sut: StepCountController!
  
  override func setUp() {
    super.setUp()
    sut = StepCountController()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  // MARK: - Initial State
  
  func testController_whenInitialized_buttonLabelIsStart() {
    // when
    sut.viewDidLoad()
    
    // then
    let title = sut.startButton.title(for: .normal)
    XCTAssertEqual(title, AppState.notStarted.nextStateButtonLabel)
  }
  
  // MARK: - In progress
  
  func testController_whenStartTapped_appIsInProgress() {
    // when
    sut.startStopPause(nil)
    
    // then
    let appState = AppModel.instance.appState
    XCTAssertEqual(appState, AppState.inProgress)
  }
  
  func testController_whenStartTapped_buttonLabelIsPause() {
    // when
    sut.startStopPause(nil)
    
    // then
    let title = sut.startButton.title(for: .normal)
    XCTAssertEqual(title, AppState.inProgress.nextStateButtonLabel)
  }
}
