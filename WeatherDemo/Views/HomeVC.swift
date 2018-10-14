//
//  HomeVC.swift
//  WeatherDemo
//
//  Created by Sharvan  Kumawat on 10/12/18.
//  Copyright © 2018 Sharvan. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    static func storyboardInstance() -> HomeVC {
        return Storyboard.kMainStoryboard.instantiateViewController(withIdentifier: HomeVC.stringRepresentation) as! HomeVC
    }
    
    @IBOutlet weak var tblCities: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ScreenTitle.home.rawValue
        setUpTableUI()
        let btnAddLocation = UIBarButtonItem(title: "Add Location", style: .plain, target: self, action: #selector(addLocation))
        navigationItem.rightBarButtonItem = btnAddLocation

    }
    
    @objc func addLocation(){
        let locationVC = LocationVC.storyboardInstance()
        self.navigationController?.pushViewController(locationVC, animated: true)
    }
    
    func setUpTableUI()  {
        tblCities.estimatedRowHeight = 44
        tblCities.separatorStyle = .singleLine
        
        tblCities.rowHeight = UITableViewAutomaticDimension
        
        tblCities.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tblCities.frame.size.width, height: 0))
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
