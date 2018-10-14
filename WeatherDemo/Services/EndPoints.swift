//
//  EndPoints.swift
//  WeatherDemo
//
//  Created by Sharvan Kumawat on 10/11/18.
//  Copyright © 2018 Sharvan. All rights reserved.
//

import Foundation

struct ForecastEndPoint {
    //Today’s forecast:
    static let baseUrlForWeather      : String = AppConstants.protocolo + AppConstants.domain + "/data/" + AppConstants.apiVersion + "/(\(APIType.Metric)?" + "appid=\(AppConstants.apiKey)" + "&units=\(AppConstants.unitsType)"
    
    //5-days forecast:
    static let baseUrlForForecast      : String = AppConstants.protocolo + AppConstants.domain + "/data/" + AppConstants.apiVersion + "/(\(APIType.Forecast)?" + "appid=\(AppConstants.apiKey)" + "&units=\(AppConstants.unitsType)"
    
}


