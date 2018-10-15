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
    
    var minTemp: Double?
    var maxTemp: Double?
    var currentTemp: Double?
    var humidity: Int?
    var windSpeed: Double?
    var date: String?
    
    
    init(_ weatherData: WeatherDataModel) {
        self.weatherData = weatherData
    
        minTemp = weatherData.minTemp
        maxTemp = weatherData.maxTemp
        currentTemp = weatherData.currentTemp
        humidity = weatherData.humidity
        windSpeed = weatherData.windSpeed
        date = weatherData.date
    }
    /**
     Creates a cellInstance method for display data on UI.
     
     - Parameter recipient: tableView, indexPath
     
     - Throws: Getting crash and error then Array don't have value and Index out of bouns exception
     
     - Returns: Cell object of the UITableViewCell
     */
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.stringRepresentation, for: indexPath) as! WeatherTableViewCell
        cell.setup(self)
        
        return cell
    }
    /**
     Creates a tapCell method for selecting any row in the tablevie and display details of selected row.
     
     - Parameter recipient: tableView, indexPath
     
     - Throws: Getting crash and error then Array don't have value and Index out of bouns exception
     
     - Returns:
     */
    func tapCell(_ tableView: UITableView, indexPath: IndexPath) {
        print("Tapped a cell")
    }
}
