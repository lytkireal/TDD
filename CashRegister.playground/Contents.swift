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

import Foundation
import XCTest

// AppCode

class CashRegister {
    var availableFunds: Decimal
    
    var transactionTotal: Decimal = 0
    
    init(availableFunds: Decimal) {
        self.availableFunds = availableFunds
    }
    
    func addItem(_ item: Decimal) {
        transactionTotal += item
    }
    
    func acceptCashPayment(_ cash: Decimal) {
        transactionTotal -= cash
        availableFunds += cash
    }
}

// TestCode

class CashRegisterTests: XCTestCase {
    
    var availableFunds: Decimal!
    var sut: CashRegister!
    var itemCost: Decimal!
    var payment: Decimal!
    
    // 1
    override func setUp() {
        super.setUp()
        availableFunds = 100
        itemCost = 42
        sut = CashRegister(availableFunds: availableFunds)
        payment = 50
    }
    
    // 2
    override func tearDown() {
        availableFunds = nil
        sut = nil
        itemCost = nil
        payment = nil
        super.tearDown()
    }
    
    func testInitAvailableFunds() {
        XCTAssertEqual(sut.availableFunds, availableFunds)
    }
    
    func testAddItem_oneItem_addsCostToTransactionTotal() {
        // when
        sut.addItem(itemCost)
        
        // then
        XCTAssertEqual(sut.transactionTotal, itemCost)
    }
    
    func testAddItem_twoItems_addsCostsToTransactionTotal () {
        // given
        testAddItem_oneItem_addsCostToTransactionTotal()
        
        let itemCostNew = Decimal(12)
        let expectedTotal = itemCost + itemCostNew
        
        // when
        sut.addItem(itemCostNew)
        
        // then
        XCTAssertEqual(expectedTotal, sut.transactionTotal)
    }
    
    func testAcceptCashPayment_subtractsPaymentFromTransactionTotal() {
        // given
        givenTransactionInProgress()
        let expected = sut.transactionTotal - payment
        
        // when
        sut.acceptCashPayment(payment)
        
        // then
        XCTAssertEqual(sut.transactionTotal, expected)
    }
    
    func testAcceptCashPayment_addsPaymentToAvailableFunds() {
        // given
        givenTransactionInProgress()
        let expected = sut.availableFunds + payment
        
        // when
        sut.acceptCashPayment(payment)
        
        // then
        XCTAssertEqual(sut.availableFunds, expected)
    }
    
    func givenTransactionInProgress() {
        sut.addItem(33)
        sut.addItem(40)
    }
}


CashRegisterTests.defaultTestSuite.run()

// Adding two items
