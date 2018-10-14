//
//  CityDetailModel.swift
//  WeatherDemo
//
//  Created by Sharvan  Kumawat on 10/14/18.
//  Copyright © 2018 Sharvan  Kumawat. All rights reserved.
//

import UIKit

class WeatherDataModel: NSObject {
    var minTemp: Int = 0
    var maxTemp: Int = 0
    var currentTemp: Int = 0
    var humidity: Int = 0
    var windSpeed: Double = 0.0
    var windDeg: Int = 0
    
    // MARK: - Intializer
    override init() {
    }
    
    convenience init(_ attributes: [AnyHashable: Any]) {
        self.init()
        let main: [String: Any] = (attributes["main"] as? [String: Any])!
        
        minTemp                  = main["temp_min"] as? Int ?? 0
        maxTemp                  = main["temp_max"] as? Int ?? 0
        currentTemp              = main["temp"] as? Int ?? 0
        humidity                 = main["humidity"] as? Int ?? 0
        
        
        let wind: [String: Any] = (attributes["wind"] as? [String: Any])!
        windSpeed                 = wind["speed"] as? Double ?? 0.0
        windDeg                  = wind["deg"] as? Int ?? 0
        
    }

}
