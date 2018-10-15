//
//  WeatherTableViewCell.swift
//  swift-mvvm
//
//  Created by Taylor Guidon on 11/30/16.
//  Copyright © 2016 ISL. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var weatherMainLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(_ viewModel: WeatherViewModel) {
        self.selectionStyle = .none
        
        guard let minTemp = viewModel.minTemp, let maxTemp = viewModel.maxTemp, let currentTemp = viewModel.currentTemp,let humidity = viewModel.humidity, let windSpeed = viewModel.windSpeed, let date = viewModel.date
             else {
                print("ViewModel is invalid")
                return
        }
        if date.length > 0 {
            weatherMainLabel.text = "Date: \(date)\nTemperature: \(currentTemp)\nMin Temperature: \(minTemp)\nMax Temperature: \(maxTemp)\nHumidity: \(humidity)\nWind Speed: \(windSpeed)"
        }
        else{
            weatherMainLabel.text = "Temperature: \(currentTemp)\nMin Temperature: \(minTemp)\nMax Temperature: \(maxTemp)\nHumidity: \(humidity)\nWind Speed: \(windSpeed)"
        }
        
    }
}
