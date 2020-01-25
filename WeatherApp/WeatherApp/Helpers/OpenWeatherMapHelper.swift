//
//  OpenWeatherMapHelper.swift
//  WeatherApp
//
//  Created by James Lapinski on 1/23/20.
//  Copyright © 2020 JWL. All rights reserved.
//

import Foundation
import CoreLocation

class OpenWeatherMapHelper {
    
    public func fetchCurrentTemperatureForCoordinates(latitude:CLLocationDegrees, longitude:CLLocationDegrees, completion:@escaping (_ weatherInfo:CurrentWeatherInformation?) -> Void) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=4f11e5f9367b11137e143e130257a48e")
        let urlRequest = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let main = try JSONDecoder().decode(CurrentWeatherInformation.self, from: data)
                completion(main)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}

