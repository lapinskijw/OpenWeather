//
//  DailyTemperatureViewControllerTests.swift
//  WeatherAppTests
//
//  Created by James Lapinski on 1/23/20.
//  Copyright © 2020 JWL. All rights reserved.
//

import XCTest
@testable import WeatherApp

class DailyTemperatureViewControllerTests: XCTestCase {
    
    var sut: DailyTemperatureViewController!
    let mockApiHelper = MockOpenWeatherMapApiHelper()

    override func setUp() {
        super.setUp()
        sut = DailyTemperatureViewController()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
}
