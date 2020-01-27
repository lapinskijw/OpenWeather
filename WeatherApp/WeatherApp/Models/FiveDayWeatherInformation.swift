//
//  FiveDayWeatherInformation.swift
//  WeatherApp
//
//  Created by James Lapinski on 1/25/20.
//  Copyright © 2020 JWL. All rights reserved.
//

import Foundation

class FiveDayWeatherInformation: Decodable {
    struct RootList : Decodable {
        let forecastItems : [ForecastItem]
        
        enum CodingKeys: String, CodingKey {
            case forecastItems = "list"
        }
    }

    struct ForecastItem : Decodable {
        let main : Main
        let weather : [Weather]
        let dateText : String

        enum CodingKeys: String, CodingKey {
            case main
            case dateText = "dt_txt"
            case weather
        }
    }

    struct Weather : Decodable {
        let icon : String
        let description: String
    }

    struct Main : Decodable {
        let temp : Double
    }
    
}
