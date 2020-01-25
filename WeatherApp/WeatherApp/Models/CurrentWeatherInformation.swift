//
//  WeatherInformation.swift
//  WeatherApp
//
//  Created by James Lapinski on 1/23/20.
//  Copyright © 2020 JWL. All rights reserved.
//

import Foundation

class CurrentWeatherInformation: Codable {
    
    struct Atmosphere: Codable {
        var temp: Double

        enum CodingKeys: String, CodingKey {
            case temp
        }
    }
    
    var atmosphere: Atmosphere
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case atmosphere = "main"
        case name
    }
    
    init(atmosphere:Atmosphere, name:String) {
        self.atmosphere = atmosphere
        self.name = name
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.atmosphere = try values.decode(Atmosphere.self, forKey: .atmosphere)
        self.name = try values.decode(String.self, forKey: .name)
    }
    
}


//    struct Coordinates: Codable {
//        var latitude: Double
//        var longitude: Double
//
//
//        enum CodingKeys: String, CodingKey {
//            case latitude = "lat"
//            case longitude = "lon"
//        }
//    }
//
//    struct Weather: Codable {
//        var identifier: Int
//        var condition: String
//        var weatherDescription: String
//        var weatherIcon: String
//
//        enum CodingKeys: String, CodingKey {
//            case identifier = "id"
//            case condition = "main"
//            case weatherDescription = "description"
//            case weatherIcon = "icon"
//        }
//    }


//        init(from decoder: Decoder) throws {
//            let values = try decoder.container(keyedBy: CodingKeys.self)
//
//            self.feelsLike = try values.decode(String.self, forKey: .feelsLike)
//            self.humidity = try values.decode(Int.self, forKey: .humidity)
//            self.pressure = try values.decode(Int.self, forKey: .pressure)
//            self.temp = try values.decode(String.self, forKey: .temp)
//            self.tempMax = try values.decode(String.self, forKey: .tempMax)
//            self.tempMin = try values.decode(String.self, forKey: .tempMin)
//
//        }
