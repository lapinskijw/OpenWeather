//
//  MockOpenWeatherMapApiHelper.swift
//  WeatherAppTests
//
//  Created by James Lapinski on 1/24/20.
//  Copyright © 2020 JWL. All rights reserved.
//

import Foundation
import CoreLocation
@testable import WeatherApp

class MockOpenWeatherMapApiHelper {
    
    var shouldReturnError = false
    var fetchCurrentTempWasCalled = false
    var mockAtmosphereObject = CurrentWeatherInformation.Atmosphere(temp: 272.50)
    var mockResponse: CurrentWeatherInformation?
    
    enum MockServiceError: Error {
        case fetchCurrentTemp
    }
}

extension MockOpenWeatherMapApiHelper: OpenWeatherMapApiHelperProtocol {
    func fetchCurrentTemperatureForCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion:@escaping (_ weatherInfo:CurrentWeatherInformation?, Error?) -> Void) {
        
        fetchCurrentTempWasCalled = true
        
        if shouldReturnError {
            completion(nil, MockServiceError.fetchCurrentTemp)
        } else {
            mockResponse = CurrentWeatherInformation(atmosphere: mockAtmosphereObject, name: "Dearborn")
            completion(mockResponse, nil)
        }

    }
    
}
