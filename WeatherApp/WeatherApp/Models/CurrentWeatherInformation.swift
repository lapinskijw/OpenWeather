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
