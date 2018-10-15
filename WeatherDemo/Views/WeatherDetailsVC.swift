//
//  WeatherDetailsVC.swift
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
    @IBOutlet weak var daysSeg: UISegmentedControl!
    
    var locationData = LocationModel()
    let serviceManager = BaseService()
    
    var weatherDataArray = [WeatherDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ScreenTitle.weatherdetails.rawValue
        
        setUpTableUI()
        
        loadDatafromWeatherAPI()
        // Do any additional setup after loading the view.
    }
    
    func setUpTableUI()  {
        tblCityDetail.estimatedRowHeight = 44
        tblCityDetail.separatorStyle = .singleLine
        
        tblCityDetail.rowHeight = UITableViewAutomaticDimension
        
        tblCityDetail.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tblCityDetail.frame.size.width, height: 0))
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        loadDatafromWeatherAPI()
    }
    
    func loadDatafromWeatherAPI() {
        Utility.ShowProgressHud(Onview: self.view)
        
        serviceManager.callEndPointForToday(daysSeg.selectedSegmentIndex == 0 ? true : false, lat: "\(locationData.latitude)", long: "\(locationData.longitude)") { [weak self] (response) in
            
            guard let strongSelf = self else { return }
            
            Utility.HideProgressHud(Onview: strongSelf.view)
            
            switch response {
            case .success(let result):
                strongSelf.weatherDataArray.removeAll()
                let list = result["list"] as? [[String: Any]]
                if let listData = list {
                    for data in listData {
                        let weatherObj = WeatherDataModel(data)
                        strongSelf.weatherDataArray.append(weatherObj)
                    }
                }
                else{
                    let weatherObj = WeatherDataModel(result)
                    strongSelf.weatherDataArray.append(weatherObj)
                }
                
                DispatchQueue.main.async {
                    strongSelf.tblCityDetail.reloadData()
                }
                
                break
            case .failure:
                Utility.showAlert(strMessage: server_error, Onview: strongSelf)
                break
            case .notConnectedToInternet:
                Utility.showAlert(strMessage: internet_error, Onview: strongSelf)
                break
            }
            
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

extension WeatherDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherData = weatherDataArray[indexPath.row]
        let weatherViewModel = WeatherViewModel(weatherData)
        return weatherViewModel.cellInstance(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherData = weatherDataArray[indexPath.row]
        let weatherViewModel = WeatherViewModel(weatherData)
        weatherViewModel.tapCell(tableView, indexPath: indexPath)
    }
}


