//
//  Utility.swift
//  WeatherDemo
//
//  Created by Sharvan  Kumawat on 10/14/18.
//  Copyright © 2018 Sharvan  Kumawat. All rights reserved.
//

import UIKit
import MBProgressHUD
import SystemConfiguration


class Utility: NSObject {
    class func ShowProgressHud(onView : UIView)
    {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: onView, animated: true)
        }
        
    }
    
    // called method when hide processing symbol
    
    class func HideProgressHud(onView : UIView)
    {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: onView, animated: true)
        }
    }
     // called global method when show alert message on UI like error and successfull
    class func showAlert(message : String , onView : UIViewController)
    {
        DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Weather Demo", message: message, preferredStyle: UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                
                onView.present(alertController, animated: true, completion: nil)
            }
        
    }
}
