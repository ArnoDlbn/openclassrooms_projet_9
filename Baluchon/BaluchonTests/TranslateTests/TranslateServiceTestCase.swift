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
        
        translate.getTranslation(text: "Bonjour, je m'appelle Arnaud!") { (translate, error) in
            XCTAssertNil(translate)
            XCTAssertNotNil(error)
            guard let error = error as? ErrorCases else {
                XCTAssert(false)
                return
            }
            if case ErrorCases.failure = error {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        let translate = TranslateService(translateSession: URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.getTranslation(text: "Bonjour, je m'appelle Arnaud!") { (translate, error) in
            XCTAssertNil(translate)
            XCTAssertNotNil(error)
            guard let error = error as? ErrorCases else {
                XCTAssert(false)
                return
            }
            if case ErrorCases.noData = error {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIncorrectResponse() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.getTranslation(text: "Bonjour, je m'appelle Arnaud!") { (translate, error) in
            XCTAssertNil(translate)
            XCTAssertNotNil(error)
            guard let error = error as? ErrorCases else {
                XCTAssert(false)
                return
            }
            if case ErrorCases.wrongResponse(statusCode: 500) = error {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIncorrectData() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.getTranslation(text: "Bonjour, je m'appelle Arnaud!") { (translate, error) in
            XCTAssertNil(translate)
            XCTAssertNotNil(error)
            guard let error = error as? ErrorCases else {
                XCTAssert(false)
                return
            }
            if case ErrorCases.errorDecode = error {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
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
}
