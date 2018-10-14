//
//  CityDetailsVC.swift
//  WeatherDemo
//
//  Created by Sharvan  Kumawat on 10/14/18.
//  Copyright © 2018 Sharvan  Kumawat. All rights reserved.
//

import UIKit

class WeatherDetailsVC: UIViewController {

    static func storyboardInstance() -> WeatherDetailsVC {
        return Storyboard.kMainStoryboard.instantiateViewController(withIdentifier: WeatherDetailsVC.stringRepresentation) as! WeatherDetailsVC
    }
    
    @IBOutlet weak var tblCityDetail: UITableView!
    var locationData = LocationModel()
    let serviceManager = BaseService()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ScreenTitle.citydetails.rawValue
        loadDatafromWeatherAPI()
        // Do any additional setup after loading the view.
    }

    func loadDatafromWeatherAPI() {
        Utility.ShowProgressHud(Onview: self.view)
        serviceManager.callEndPoint(lat: "\(locationData.latitude)", long: "\(locationData.longitude)") { response in
            Utility.HideProgressHud(Onview: self.view)
            print("re = \(response)")
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
