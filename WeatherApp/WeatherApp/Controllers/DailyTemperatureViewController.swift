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
        self.navigationItem.title = "Current Temperature"
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
        }
    }
    
    func getTempFromCoordinates(lat:CLLocationDegrees, long:CLLocationDegrees) {
        let helper = OpenWeatherMapApiHelper()
        helper.fetchCurrentTemperatureForCoordinates(latitude: lat, longitude: long) { (currentWeatherInformation, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.presentErrorAlertView()
                }
            }
            
            if let currentWeatherInformation = currentWeatherInformation {
                let utility = Utility()
                self.currentTemperature = utility.convertTemp(temp: currentWeatherInformation.atmosphere.temp, from: .kelvin, to: .fahrenheit)
                self.currentCity = currentWeatherInformation.name
                DispatchQueue.main.async {
                    self.updateViews()
                }
            }
        }
    }
    
    func presentErrorAlertView() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong, please try again later.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func presentFiveDayViewController() {
        let fiveDayWeatherViewController = FiveDayWeatherViewController(lat: latitude, long: longitude)
        self.navigationController?.pushViewController(fiveDayWeatherViewController, animated: true)
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
        fiveDayForecastButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        fiveDayForecastButton.layer.cornerRadius = 20
        fiveDayForecastButton.addTarget(self, action: #selector(presentFiveDayViewController), for: .touchUpInside)
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

