//
//  TranslateServiceTestCase.swift
//  BaluchonTests
//
//  Created by Arnaud Dalbin on 25/03/2020.
//  Copyright © 2020 Arnaud Dalbin. All rights reserved.
//

import XCTest
@testable import Baluchon

class TranslateServiceTestCase: XCTestCase {
    
    func testGetTranslationShouldPostFailedCallbackIfError() {
        let translate = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.getTranslation(text: "Bonjour, je m'appelle Arnaud!") { (translate, success) in
            XCTAssertNotNil(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        let translate = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.getTranslation(text: "Bonjour, je m'appelle Arnaud!") { (translate, success) in
            XCTAssertNil(translate)
            XCTAssertNil(success)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIncorrectResponse() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.getTranslation(text: "Bonjour, je m'appelle Arnaud!") { (translate, success) in
            XCTAssertNil(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIncorrectData() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.getTranslation(text: "Bonjour, je m'appelle Arnaud!") { (translate, success) in
            XCTAssertNotNil(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.getTranslation(text: "Bonjour, je m'appelle Arnaud!") { (translate, success) in
            let fakeTranslation: String = "Hello, my name is Arnaud!"
            
            XCTAssertEqual(fakeTranslation, translate!.data.translations[0].translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
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
