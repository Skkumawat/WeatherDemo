//
//  WeatherViewModel.swift
//  WeatherDemo
//
//  Created by Sharvan  Kumawat on 10/14/18.
//  Copyright © 2018 Sharvan. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherViewModel {
    var weatherData: WeatherDataModel
    
    var minTemp: Int?
    var maxTemp: Int?
    var currentTemp: Int?
    var humidity: Int?
    var windSpeed: Double?
    var windDeg: Int?
    
    
    init(_ weatherData: WeatherDataModel) {
        self.weatherData = weatherData
    
        minTemp = weatherData.minTemp
        maxTemp = weatherData.maxTemp
        currentTemp = weatherData.currentTemp
        humidity = weatherData.humidity
        windDeg = weatherData.windDeg
        windSpeed = Double(weatherData.windSpeed)
    }
    
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.stringRepresentation, for: indexPath) as! WeatherTableViewCell
        cell.setup(self)
        
        return cell
    }
    
    func tapCell(_ tableView: UITableView, indexPath: IndexPath) {
        print("Tapped a cell")
    }
}
