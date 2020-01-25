//
//  OpenWeatherMapHelper.swift
//  WeatherApp
//
//  Created by James Lapinski on 1/23/20.
//  Copyright © 2020 JWL. All rights reserved.
//

import Foundation
import CoreLocation

class OpenWeatherMapApiHelper: OpenWeatherMapApiHelperProtocol {

    
    enum APIError: Error {
        case apiServiceError
    }
    
    func fetchCurrentTemperatureForCoordinates(latitude:CLLocationDegrees, longitude:CLLocationDegrees, completion:@escaping (_ weatherInfo:CurrentWeatherInformation?, Error?) -> Void) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=4f11e5f9367b11137e143e130257a48e")
        let urlRequest = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil, APIError.apiServiceError)
                return
            }
            
            do {
                let main = try JSONDecoder().decode(CurrentWeatherInformation.self, from: data)
                completion(main, nil)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}

