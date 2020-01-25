//
//  DailyTemperatureViewController.swift
//  WeatherApp
//
//  Created by James Lapinski on 1/23/20.
//  Copyright © 2020 JWL. All rights reserved.
//

import UIKit
import CoreLocation
import SnapKit

class DailyTemperatureViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var currentTemperature: String?
    var currentCity: String?
    
    var temperatureLabel = UILabel()
    var cityLabel = UILabel()
    var fiveDayForecastButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        getUserLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateViews()
    }
    
    func getUserLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }

        if let location = locationManager.location {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            getTempFromCoordinates(lat: latitude!, long: longitude!)
            print("\(latitude!), \(longitude!)")
        }
    }
    
    func getTempFromCoordinates(lat:CLLocationDegrees, long:CLLocationDegrees) {
        let helper = OpenWeatherMapApiHelper()
        helper.fetchCurrentTemperatureForCoordinates(latitude: lat, longitude: long) { (currentWeatherInformation, error) in
            if error != nil {
                self.presentErrorAlertView()
            }
            
            if let currentWeatherInformation = currentWeatherInformation {
                self.currentTemperature = self.convertTemp(temp: currentWeatherInformation.atmosphere.temp, from: .kelvin, to: .fahrenheit)
                self.currentCity = currentWeatherInformation.name
                DispatchQueue.main.async {
                    self.updateViews()
                }
            }
        }
    }
    
    func presentErrorAlertView() {
        // to do
    }
    
    // MARK: - Views and Constraints
    
    func updateViews() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        temperatureLabel.font = UIFont.systemFont(ofSize: 60)
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .blue
        temperatureLabel.text = currentTemperature
        self.view.addSubview(temperatureLabel)
        
        cityLabel.font = UIFont.systemFont(ofSize: 25)
        cityLabel.textAlignment = .center
        cityLabel.textColor = .blue
        if CLLocationManager.locationServicesEnabled() {
            cityLabel.text = currentCity
        } else {
            cityLabel.text = "Location services not authroized."
        }
        
        self.view.addSubview(cityLabel)
        
        fiveDayForecastButton.setTitle("VIEW 5 DAY FORECAST", for: .normal)
        fiveDayForecastButton.backgroundColor = .blue
        fiveDayForecastButton.setTitleColor(.white, for: .normal)
        fiveDayForecastButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        fiveDayForecastButton.layer.cornerRadius = 20
        self.view.addSubview(fiveDayForecastButton)
    }
    
    func setupConstraints() {
        temperatureLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        cityLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(temperatureLabel.snp.bottom).offset(20)
        }
        
        fiveDayForecastButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - CLLocationManagerDelegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestLocation()
        case .authorizedWhenInUse:
            self.getUserLocation()
        default:
            // do something
            updateViews()
        }
    }
    
}

    // MARK: - DailyTemperatureViewController Extension

extension DailyTemperatureViewController {
    func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .providedUnit
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return measurementFormatter.string(from: output)
    }
}

