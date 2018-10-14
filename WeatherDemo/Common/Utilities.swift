//
//  Utilities.swift
//  WeatherDemo
//
//  Created by Sharvan Kumawat on 10/14/18.
//  Copyright © 2018 Sharvan. All rights reserved.
//

import Foundation
import SwiftyJSON

class Utilities {
    class func loadWeatherFromJSON(json: JSON) -> [WeatherDataModel] {
        var weatherDataArray: [WeatherDataModel] = []
        
        guard let dailyWeatherArray = json["daily"]["data"].array else {
            print("No array")
            return []
        }
        
        for day in dailyWeatherArray {
            guard let rawUnixTime = day["time"].double,
                let minTemp = day["temperatureMin"].double,
                let maxTemp = day["temperatureMax"].double,
                let summary = day["summary"].string else {
                    print("Error with data")
                    return []
            }
            let weatherData = WeatherDataModel()
            weatherDataArray.append(weatherData)
        }
        
        return weatherDataArray
    }
}
