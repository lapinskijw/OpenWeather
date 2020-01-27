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
        let list : [List]
    }

    struct List : Decodable {
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
