//
//  BaseService.swift
//  WeatherDemoTests
//
//  Created by Sharvan Kumawat on 10/15/18.
//  Copyright © 2018 Sharvan  Kumawat. All rights reserved.
//

import XCTest
@testable import WeatherDemo

class BaseServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWeatherApi() {
        
        let serviceManager = BaseService()
        let location = LocationModel()
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        
        
        location.address = "Ahmedabad"
        location.latitude = 23.0225
        location.longitude = 72.5714
        
        serviceManager.callEndPointForToday(true , lat: "\(location.latitude)", long: "\(location.longitude)") { (response) in
            
            switch response {
            case .success(let result):
                print("\(result.description)")
                statusCode = 200
                promise.fulfill()
                break
            case .failure:
                statusCode = 400
                promise.fulfill()
                break
            case .notConnectedToInternet:
                statusCode = 400
                promise.fulfill()
                break
            }
            
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(statusCode, 200)
        
    }
    
}
