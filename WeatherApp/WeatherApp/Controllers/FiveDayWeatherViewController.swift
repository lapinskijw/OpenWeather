//
//  FiveDayWeatherViewController.swift
//  WeatherApp
//
//  Created by James Lapinski on 1/25/20.
//  Copyright © 2020 JWL. All rights reserved.
//

import UIKit
import CoreLocation
import SnapKit

class FiveDayWeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var forecastTableView = UITableView()
    var arrayOfListObjects = [FiveDayWeatherInformation.List]()
    var utility = Utility()
    let dateFormatter = DateFormatter()
    
    init(lat:CLLocationDegrees?, long:CLLocationDegrees?) {
        self.latitude = lat
        self.longitude = long
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let latitude = latitude, let longitude = longitude {
            getForecastFromCoordinates(lat: latitude, long: longitude)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        self.navigationItem.title = "5 Day Forecast"
        self.navigationController?.navigationBar.isTranslucent = false
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        setupViews()
        setupConstraints()
    }
    
    func getForecastFromCoordinates(lat:CLLocationDegrees, long:CLLocationDegrees) {
        let helper = OpenWeatherMapApiHelper()
        helper.fetchFiveDayForecastForCoordinates(latitude: lat, longitude: long) { (fiveDayForecastInfos, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.presentErrorAlertView()
                }
            }
            
            if let listObjects = fiveDayForecastInfos {
                self.arrayOfListObjects = listObjects
                
                DispatchQueue.main.async {
                    self.forecastTableView.reloadData()
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
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfListObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! ForecastTableViewCell
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        let item = arrayOfListObjects[indexPath.row]
        cell.tempLabel.text = utility.convertTemp(temp: item.main.temp, from: .kelvin, to: .fahrenheit)
        
        let date = dateFormatter.date(from: item.dateText)
        cell.dayOfWeekLabel.text = date?.dayOfWeek()
        cell.timeLabel.text = date?.timeOfDay()
    
        cell.weatherDescLabel.text = item.weather[0].description.capitalized        
        cell.weatherIconImageView.downloadFrom(link: "http://openweathermap.org/img/w/" + item.weather[0].icon + ".png")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    // MARK: - Views and Constraints
    
    func setupViews() {
        forecastTableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: "MyCell")
        forecastTableView.dataSource = self
        forecastTableView.delegate = self
        forecastTableView.backgroundColor = .white
        self.view.addSubview(forecastTableView)
    }
    
    func setupConstraints() {
        forecastTableView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Required Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
