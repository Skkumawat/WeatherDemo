//
//  SettingsVC.swift
//  WeatherDemo
//
//  Created by Sharvan  Kumawat on 10/12/18.
//  Copyright © 2018 Sharvan. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    static func storyboardInstance() -> SettingsVC {
        return Storyboard.kMainStoryboard.instantiateViewController(withIdentifier: SettingsVC.stringRepresentation) as! SettingsVC
    }
    
    @IBOutlet weak var switchForReset: UISwitch!
    @IBOutlet weak var unitTypeSeg: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchForReset.isOn = false
        self.title = ScreenTitle.settings.rawValue

        // Do any additional setup after loading the view.
    }

    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        
    }
    @IBAction func switchControlChanged(_ sender: UISwitch) {
        if sender.isOn == true {
            //Delete all bookmarked cites
            CoreDataManager.deleteAllCitiesData(entityName: "Address", completionHandler: { success in
                if success {
                    self.switchForReset.isOn = false
                    Utility.showAlert(strMessage: "All bookmark cities deleted successfully", Onview: self)
                    self.tabBarController?.selectedIndex = 0
                }
                else{
                    Utility.showAlert(strMessage: "All bookmark cities are not deleted, Please try again!", Onview: self)
                }
            })
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
