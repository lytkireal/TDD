/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
@testable import FitNess

class StepCountControllerTests: XCTestCase {

  var sut: StepCountController!

  // MARK: - Test Lifecycle

  override func setUp() {
    super.setUp()
    let rootController = loadRootViewController()
    sut = rootController.stepController
  }

  override func tearDown() {
    AppModel.instance.restart()
    sut.updateUI()
    super.tearDown()
  }

  // MARK: - Given
  
  func givenGoalSet() {
    AppModel.instance.dataModel.goal = 1000
  }
  
  func givenInProgress() {
    givenGoalSet()
    sut.startStopPause(nil)
  }
  
  func givenPaused() {
    givenInProgress()
    whenStartStopPauseCalled()
  }
  
  func givenCompleted() {
    AppModel.instance.setToComplete()
  }
  
  func givenCaught() {
    AppModel.instance.setToCaught()
  }
  
  // MARK: - When

  fileprivate func whenStartStopPauseCalled() {
    sut.startStopPause(nil)
  }

  // MARK: - Initial State

  func testController_whenCreated_buttonLabelIsStart() {

    let text = sut.startButton.title(for: .normal)
    XCTAssertEqual(text, AppState.notStarted.nextStateButtonLabel)
  }

  // MARK: - Goal
  
  func testDataModel_whenGoalUpdate_updatesToNewGoal() {
    // given
    let newGoal = 50
    
    // when
    sut.updateGoal(newGoal: newGoal)
  
    // then
    XCTAssertEqual(AppModel.instance.dataModel.goal, newGoal)
  }
  
  // MARK: - In Progress

  func testController_whenStartTapped_appIsInProgress() {
    // given
    givenInProgress()

    // then
    let state = AppModel.instance.appState
    XCTAssertEqual(state, AppState.inProgress)
  }

  // MARK: - Pause
  
  func testController_whenStartTapped_buttonLabelIsPause() {
    // given
    givenGoalSet()
    
    // when
    whenStartStopPauseCalled()
    
    // then
    let text = sut.startButton.title(for: .normal)
    XCTAssertEqual(text, AppState.inProgress.nextStateButtonLabel)
  }
  
  func testControllerInProgress_whenPauseTapped_appIsPaused() {
    // given
    givenInProgress()
    
    // when
    whenStartStopPauseCalled()
    
    // then
    XCTAssertEqual(AppModel.instance.appState, .paused)
  }
  
  func testControllerInProgress_whenPauseTapped_buttonLabelIsResume() {
    // given
    givenInProgress()
    
    // when
    whenStartStopPauseCalled()
    
    // then
    let buttonLabelTitle = sut.startButton.title(for: .normal)
    XCTAssertEqual(buttonLabelTitle, AppModel.instance.appState.nextStateButtonLabel)
  }
  
  func testControllerInPaused_whenResumeTapped_appIsInProgress() {
    // given
    givenPaused()

    // when
    whenStartStopPauseCalled()

    // then
    XCTAssertEqual(AppModel.instance.appState, .inProgress)
  }
  
  // MARK: - Terminal state
  
  func testControllerCompleted_whenRestartTapped_appIsNotStarted() {
    // given
    givenCompleted()
    
    // when
    whenStartStopPauseCalled()
    
    // then
    XCTAssertEqual(AppModel.instance.appState, .notStarted)
  }
  
  func testControllerCaught_whenRestartTapped_appIsNotStarted() {
    // given
    givenCaught()
    
    // when
    whenStartStopPauseCalled()
    
    // then
    XCTAssertEqual(AppModel.instance.appState, .notStarted)
  }
  
  // MARK: - Chase View
  
  func testChaseView_whenLoaded_isNotStarted() {
    // when loaded, then
    let chaseView = sut.chaseView
    XCTAssertEqual(chaseView?.state, AppState.notStarted)
  }
  
  func testChaseView_whenInProgress_viewIsInProgress() {
    // given
    givenInProgress()
    
    // then
    let chaseView = sut.chaseView
    XCTAssertEqual(chaseView?.state, AppState.inProgress)
  }
}
