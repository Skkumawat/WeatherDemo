//
//  HomeVCTests.swift
//  WeatherDemoTests
//
//  Created by admin on 16/10/18.
//  Copyright © 2018 Sharvan  Kumawat. All rights reserved.
//

import XCTest
@testable import WeatherDemo

class HomeVCTests: XCTestCase {
    
    var homeVC: HomeVC!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        homeVC = HomeVC.storyboardInstance()
        

        let location1 = LocationModel()
        location1.address = "New Delhi"
        location1.latitude = 28.6139
        location1.longitude = 77.2090
        
        let location2 = LocationModel()
        location2.address = "Ahmedabad"
        location2.latitude = 23.0225
        location2.longitude = 72.5714

        let location3 = LocationModel()
        location3.address = "Jaipur"
        location3.latitude = 26.9124
        location3.longitude = 75.7873
        
        CoreDataManager.saveAddressData(locationData: location1)
        CoreDataManager.saveAddressData(locationData: location2)
        CoreDataManager.saveAddressData(locationData: location3)

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSearchLocation1() {
        
        let locations = homeVC.getSearchData(search: "Jai")
        
        if let location = locations.first {
            XCTAssertEqual(location.address, "Jaipur", "Location found")
        }

    }
    
    func testSearchLocation2() {
        
        let locations = homeVC.getSearchData(search: "meda")
        
        if let location = locations.first {
            XCTAssertEqual(location.address, "Ahmedabad", "Location not found")
        }
        
    }
    
}
