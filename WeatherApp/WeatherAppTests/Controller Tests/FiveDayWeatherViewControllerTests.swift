//
//  FiveDayWeatherViewControllerTests.swift
//  WeatherAppTests
//
//  Created by James Lapinski on 1/26/20.
//  Copyright © 2020 JWL. All rights reserved.
//

import XCTest
@testable import WeatherApp

class FiveDayWeatherViewControllerTests: XCTestCase {
    
    var sut: FiveDayWeatherViewController!
    let mockApiHelper = MockOpenWeatherMapApiHelper()

    override func setUp() {
        super.setUp()
        sut = FiveDayWeatherViewController(lat: 42.289276123046875, long: -83.20903058171571)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
