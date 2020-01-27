//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by James Lapinski on 1/25/20.
//  Copyright © 2020 JWL. All rights reserved.
//

import UIKit
import SnapKit

class ForecastTableViewCell: UITableViewCell {
    
    var dayOfWeekLabel = UILabel()
    var timeLabel = UILabel()
    var tempLabel = UILabel()
    var separatorLine = UIView()
    var dateTimeStack = UIStackView()
    var weatherDescLabel = UILabel()
    var weatherIconImageView = UIImageView()
    var weatherIconDescriptionStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        
        dayOfWeekLabel.font = UIFont.boldSystemFont(ofSize: 20)
        dayOfWeekLabel.textAlignment = .center
        
        timeLabel.font = UIFont.systemFont(ofSize: 20)
        timeLabel.textAlignment = .center
        
        dateTimeStack.alignment = .center
        dateTimeStack.axis = .vertical
        dateTimeStack.distribution = .equalSpacing
        dateTimeStack.spacing = 2
        dateTimeStack.addArrangedSubview(dayOfWeekLabel)
        dateTimeStack.addArrangedSubview(timeLabel)
        self.contentView.addSubview(dateTimeStack)
        
        separatorLine.backgroundColor = .gray
        self.contentView.addSubview(separatorLine)
        
        tempLabel.font = UIFont.systemFont(ofSize: 40)
        tempLabel.textAlignment = .center
        self.contentView.addSubview(tempLabel)
        
        weatherDescLabel.font = UIFont.systemFont(ofSize: 12)
        weatherDescLabel.textAlignment = .center
        
        weatherIconDescriptionStack.alignment = .center
        weatherIconDescriptionStack.axis = .vertical
        weatherIconDescriptionStack.distribution = .equalSpacing
        weatherIconDescriptionStack.spacing = 2
        weatherIconDescriptionStack.addArrangedSubview(weatherIconImageView)
        weatherIconDescriptionStack.addArrangedSubview(weatherDescLabel)
        self.contentView.addSubview(weatherIconDescriptionStack)
    }
    
    func setupConstraints() {
    
        dateTimeStack.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(60)
        }
        
        separatorLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalTo(dateTimeStack.snp.trailing).offset(10)
            make.width.equalTo(0.5)
        }
        
        tempLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalTo(separatorLine.snp.trailing).offset(20)
        }
        
        weatherIconDescriptionStack.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-10)
            make.width.equalTo(100)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
