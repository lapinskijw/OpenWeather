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
    var stubFetchTempResponse: CurrentWeatherInformation?
    
    var fetchFiveDayForecastWasCalled = false
    var mockMainObject = FiveDayWeatherInformation.Main(temp: 272.50)
    var mockWeatherObject = FiveDayWeatherInformation.Weather(icon: "icon", description: "Cloudy")
    var stubFiveDayResponse: FiveDayWeatherInformation.ForecastItem?
    
    enum MockServiceError: Error {
        case fetchCurrentTemp
        case fetchFiveDay
    }
}

extension MockOpenWeatherMapApiHelper: OpenWeatherMapApiHelperProtocol {
    
    func fetchCurrentTemperatureForCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion:@escaping (_ weatherInfo:CurrentWeatherInformation?, Error?) -> Void) {
        
        fetchCurrentTempWasCalled = true
        
        if shouldReturnError {
            completion(nil, MockServiceError.fetchCurrentTemp)
        } else {
            stubFetchTempResponse = CurrentWeatherInformation(atmosphere: mockAtmosphereObject, name: "Dearborn")
            completion(stubFetchTempResponse, nil)
        }
    }
    
    func fetchFiveDayForecastForCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (_ weatherForecasts:[FiveDayWeatherInformation.ForecastItem]?, Error?) -> Void) {
        
        fetchFiveDayForecastWasCalled = true
        
        if shouldReturnError {
            completion(nil, MockServiceError.fetchFiveDay)
        } else {
            self.stubFiveDayResponse = FiveDayWeatherInformation.ForecastItem(main: mockMainObject, weather: [mockWeatherObject], dateText: "2020-01-25 21:00:00")
            completion([stubFiveDayResponse!], nil)
        }
        
    }
    
}
