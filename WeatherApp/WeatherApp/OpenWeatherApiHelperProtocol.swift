//
//  OpenWeatherApiHelperProtocol.swift
//  WeatherApp
//
//  Created by James Lapinski on 1/24/20.
//  Copyright © 2020 JWL. All rights reserved.
//

import Foundation
import CoreLocation

protocol OpenWeatherMapApiHelperProtocol {
    func fetchCurrentTemperatureForCoordinates(latitude:CLLocationDegrees, longitude:CLLocationDegrees, completion:@escaping (_ weatherInfo:CurrentWeatherInformation?, Error?) -> Void)
}
