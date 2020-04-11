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
        
        weather.getWeather(city: "Paris") { (weather, success) in
            XCTAssertNotNil(success)
            XCTAssertNil(weather)
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
            guard let error = error as? WeatherService.Error else {
                XCTAssert(false)
                return
            }
            if case WeatherService.Error.noData = error {
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
            guard let error = error as? WeatherService.Error else {
                XCTAssert(false)
                return
            }
            if case WeatherService.Error.wrongResponse(statusCode: 500) = error {
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
        
        weather.getWeather(city: "Paris") { (weather, success) in
            XCTAssertNotNil(success)
            XCTAssertNil(weather)
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
