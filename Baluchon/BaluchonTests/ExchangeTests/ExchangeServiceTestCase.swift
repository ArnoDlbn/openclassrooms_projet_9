//
//  ExchangeServiceTestCase.swift
//  BaluchonTests
//
//  Created by Arnaud Dalbin on 25/03/2020.
//  Copyright © 2020 Arnaud Dalbin. All rights reserved.
//

import XCTest
@testable import Baluchon

class ExchangeServiceTestCase: XCTestCase {
    
    func testGetExchangeShouldPostFailedCallbackIfError() {
        let exchange = ExchangeService(exchangeSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchange.getExchange() { (exchange, success) in
            XCTAssertNotNil(success)
            XCTAssertNil(exchange)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeShouldPostFailedCallbackIfNoData() {
        let exchange = ExchangeService(exchangeSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchange.getExchange() { (exchange, success) in
            XCTAssertNil(exchange)
            XCTAssertNil(success)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeShouldPostFailedCallbackIncorrectResponse() {
        let exchange = ExchangeService(exchangeSession: URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchange.getExchange() { (exchange, success) in
            XCTAssertNil(success)
            XCTAssertNil(exchange)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeShouldPostFailedCallbackIncorrectData() {
        let exchange = ExchangeService(exchangeSession: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchange.getExchange() { (exchange, success) in
            XCTAssertNotNil(success)
            XCTAssertNil(exchange)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let exchange = ExchangeService(exchangeSession: URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchange.getExchange() { (exchange, success) in
            let fakeExchangeUsd: Double = 1.084646
            let fakeExchangeCad: Double = 1.554206
            let fakeExchangeJpy: Double = 120.849089

            XCTAssertEqual(fakeExchangeUsd, exchange!.rates["USD"])
            XCTAssertEqual(fakeExchangeCad, exchange!.rates["CAD"])
            XCTAssertEqual(fakeExchangeJpy, exchange!.rates["JPY"])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testConvertFromShouldReturnStringFromString() {
        let exchange = ExchangeService()
        
        var result = exchange.convertFrom(label: "Australian Dollar")
        XCTAssertEqual(result, "AUD")
        
        result = exchange.convertFrom(label: "Canadian Dollar")
        XCTAssertEqual(result, "CAD")
        
        result = exchange.convertFrom(label: "Swiss Franc")
        XCTAssertEqual(result, "CHF")
        
        result = exchange.convertFrom(label: "Euro")
        XCTAssertEqual(result, "EUR")
        
        result = exchange.convertFrom(label: "British Pound Sterling")
        XCTAssertEqual(result, "GBP")
        
        result = exchange.convertFrom(label: "Japanese Yen")
        XCTAssertEqual(result, "JPY")
        
        result = exchange.convertFrom(label: "United States Dollar")
        XCTAssertEqual(result, "USD")

    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
