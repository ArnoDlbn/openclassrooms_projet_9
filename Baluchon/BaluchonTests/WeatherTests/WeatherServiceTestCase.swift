//
//  WeatherServiceTestCase.swift
//  BaluchonTests
//
//  Created by Arnaud Dalbin on 25/03/2020.
//  Copyright © 2020 Arnaud Dalbin. All rights reserved.
//

import XCTest
@testable import Baluchon

class WeatherServiceTestCase: XCTestCase {
    
    func testGetWeatherShouldPostFailedCallbackIfError() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
       
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(city: "Paris") { (weather, error) in
            XCTAssertNil(weather)
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
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil))
       
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(city: "Paris") { (weather, error) in
            XCTAssertNil(weather)
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
    
    func testGetWeatherShouldPostFailedCallbackIncorrectResponse() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(city: "Paris") { (weather, error) in
            XCTAssertNil(weather)
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
    
    func testGetWeatherShouldPostFailedCallbackIncorrectData() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(city: "Paris") { (weather, error) in
            XCTAssertNil(weather)
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
    
    func testGetWeatehrShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weather = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weather.getWeather(city: "Paris") { (weather, success) in
            let fakeWeatherWind: Float = 0.5
            let fakeWeatherTemp: Float = 11.31
            let fakeWeather: String = "Clear"
            
            XCTAssertEqual(fakeWeatherWind, weather!.wind.speed)
            XCTAssertEqual(fakeWeatherTemp, weather!.main.temp)
            XCTAssertEqual(fakeWeather, weather!.weather[0].main)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
