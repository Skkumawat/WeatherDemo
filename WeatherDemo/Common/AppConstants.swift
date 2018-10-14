//
//  AppConstants.swift
//  WeatherDemo
//
//  Created by Sharvan Kumawat on 10/11/18.
//  Copyright © 2018 Sharvan. All rights reserved.
//

import Foundation
import UIKit


var helpURL: String {
    return "https://www.mobiquityinc.com/about-us"
}
enum ScreenTitle: String {
    case home = "Home"
    case weatherdetails = "Weather Details"
    case help = "Help"
    case settings = "Settings"
    case location = "Add Location"
}


enum APIType: String {
    case Weather = "weather"
    case Forecast = "forecast"
}

struct AppConstants {
    static let protocolo    : String = "http://"
    static let apiVersion   : String = "2.5"
    static let domain       : String = "api.openweathermap.org"
    static let apiKey       : String = "c6e381d8c7ff98f0fee43775817cf6ad"
    static let unitsType    : String = "metric"
}

public struct Storyboard {
    static let kMainStoryboard              = UIStoryboard(name: "Main",     bundle: nil)
    static let kTabBarStoryboard            = UIStoryboard(name: "Tabbar",   bundle: nil)
    
}
