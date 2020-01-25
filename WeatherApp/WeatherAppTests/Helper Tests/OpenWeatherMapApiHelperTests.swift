//
//  OpenWeatherApiHelperTests.swift
//  WeatherAppTests
//
//  Created by James Lapinski on 1/24/20.
//  Copyright © 2020 JWL. All rights reserved.
//

import XCTest
@testable import WeatherApp

class OpenWeatherMapApiHelperTests: XCTestCase {

    let mock = MockOpenWeatherMapApiHelper()
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testOpenWeatherMapApiHelper_calledGetCurrentTemp_funcWasCalled() {
        let exp = self.expectation(description: "Weather info parse is not nil")
        
        mock.fetchCurrentTemperatureForCoordinates(latitude: 42.289276123046875, longitude: -83.20903058171571) { (currentWeatherInfo, error)  in
            XCTAssertEqual(self.mock.fetchCurrentTempWasCalled, true)
            exp.fulfill()
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testOpenWeatherMapApiHelper_calledGetCurrentTemp_weatherInfoNotNil() {
        
        let exp = self.expectation(description: "Weather info parse is not nil")
        
        mock.fetchCurrentTemperatureForCoordinates(latitude: 42.289276123046875, longitude: -83.20903058171571) { (currentWeatherInfo, error) in
            XCTAssertNotNil(currentWeatherInfo)
            exp.fulfill()
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testOpenWeatherMapApiHelper_getCurrentTempError_errorIsNotNil() {
        
        let exp = self.expectation(description: "Error is not nil")
        
        mock.shouldReturnError = true
        
        mock.fetchCurrentTemperatureForCoordinates(latitude: 42.289276123046875, longitude: -83.20903058171571) { (currentWeatherInfo, error) in
            XCTAssertNotNil(error)
            exp.fulfill()
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }


}
