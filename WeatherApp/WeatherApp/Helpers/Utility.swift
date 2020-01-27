//
//  HelperFunctions.swift
//  WeatherApp
//
//  Created by James Lapinski on 1/26/20.
//  Copyright © 2020 JWL. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .providedUnit
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return measurementFormatter.string(from: output)
    }
    
}

    // MARK: - Extensions

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    func timeOfDay() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: self)
    }
}

extension UIImageView {
    func downloadFrom(link:String?) {
        if link == nil{
            self.image = UIImage(named: "error")
            return
        }
        
        if let url = URL(string: link!) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
                guard let data = data, error == nil else {
                    self.image = UIImage(named: "error")
                    return
                }
                DispatchQueue.main.async { () -> Void in
                    self.image = UIImage(data: data)
                }
            }).resume()
        } else {
            self.image = UIImage(named: "error")
        }
    }
}
