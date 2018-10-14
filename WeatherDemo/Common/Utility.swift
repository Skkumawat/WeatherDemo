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
    class func ShowProgressHud(Onview : UIView)
    {
        DispatchQueue.main.async {
            
            MBProgressHUD.showAdded(to: Onview, animated: true)
            
        }
        
    }
    
    // called method when hide processing symbol
    
    class func HideProgressHud(Onview : UIView)
    {
        DispatchQueue.main.async {
            
            MBProgressHUD.hide(for: Onview, animated: true)
            
        }
    }
}
