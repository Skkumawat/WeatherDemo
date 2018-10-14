//
//  LocationManager.swift
//  WeatherDemo
//
//  Created by Sharvan Kumawat on 10/13/18.
//  Copyright © 2018 Sharvan. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class LocationManager {
    
    //MARK:- GET LOCATION
    
    class func getAddressFromLatitudeLongitude(location: CLLocation, completionHandler: @escaping (String?) -> ()) {
        
        var adressString = ""
    
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            // Place details
            
            if error == nil, let place =  placemarks{
                var placeMark: CLPlacemark!
                
                placeMark = place[0]
                
                
                if placeMark.thoroughfare != nil {
                    adressString = adressString + placeMark.thoroughfare! + ", "
                }
                if placeMark.subThoroughfare != nil {
                    adressString = adressString + placeMark.subThoroughfare! + " "
                }
                if placeMark.locality != nil {
                    adressString = adressString + placeMark.locality! + ", "
                }
                if placeMark.postalCode != nil {
                    adressString = adressString + placeMark.postalCode! + " "
                }
                if placeMark.administrativeArea != nil {
                    adressString = adressString + placeMark.administrativeArea! + ", "
                }
                if placeMark.country != nil {
                    adressString = adressString + placeMark.country!
                }
                completionHandler(adressString)
                //self.txtStart.text = "\(adressString)"
            }
            else{
                print("Getting error when fetch address")
            }
        })
    }
}

