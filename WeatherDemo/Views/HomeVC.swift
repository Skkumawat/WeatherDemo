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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var locations = [LocationModel]()
    var searchLocations = [LocationModel]()
    var isSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ScreenTitle.home.rawValue
        
        setUpTableUI()
        
        let btnAddLocation = UIBarButtonItem(title: "Add Location", style: .plain, target: self, action: #selector(addLocation))
        navigationItem.rightBarButtonItem = btnAddLocation

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllCities()
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
    func getAllCities(){
        locations.removeAll()
        CoreDataManager.getAllCities { locations in
            self.locations = locations
            self.tblCities.reloadData()
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
extension HomeVC : UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool{
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.endEditing(true)
        isSearch = true
        getSearchData(search: searchBar.text ?? "")
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        isSearch = false
        self.view.endEditing(true)
        tblCities.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar,textDidChange searchText: String) {
        let searchTxt = searchBar.text?.trim()
        searchBar.text = searchText
        isSearch = true
        getSearchData(search: searchTxt ?? "")
    }
    
    func getSearchData(search: String) {
        searchLocations.removeAll()
        for model in locations {
            if search.count == 0 {
                searchLocations.append(model)
            }else if search.count > 0 {
                if model.address.lowercased().range(of: search.lowercased()) != nil  {
                    searchLocations.append(model)
                }
            }
        }
        tblCities.reloadData()
    }
}
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearch ? searchLocations.count : locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableCell.stringRepresentation, for: indexPath) as! LocationTableCell
        
        let location = isSearch ? self.searchLocations[indexPath.row] : self.locations[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        cell.lblAddress.text = location.address
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return  isSearch ? false  : true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            CoreDataManager.deleteLocation(location: self.locations[indexPath.row])
            
            tblCities.beginUpdates()
            self.locations.remove(at: indexPath.row)
            tblCities.deleteRows(at: [indexPath], with: .automatic)
            tblCities.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let vc = UserDetails.storyboardInstance()
       // vc.user = self.users[indexPath.row]
      //  self.navigationController?.pushViewController(vc, animated: true)
    }
}
