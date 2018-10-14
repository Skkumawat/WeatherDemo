//
//  CoreDataManager.swift
//  WeatherDemo
//
//  Created by Sharvan  Kumawat on 10/14/18.
//  Copyright © 2018 Sharvan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    static let appdelgate = (UIApplication.shared.delegate as! AppDelegate)
    static let context = appdelgate.persistentContainer.viewContext
    
    class func saveAddressData(cityData: CitiyModel) {
        let city = Address(context: context)
        
        city.address = cityData.address
        city.latitude = cityData.latitude
        city.longitude = cityData.longitude
        appdelgate.saveContext()
    }
    
    class func deleteAllCitiesData(entityName: String) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        fetchRequest.returnsObjectsAsFaults = false
        
        let result = try? context.fetch(fetchRequest)
        
        for object in result! {
            context.delete(object as! NSManagedObject)
        }
    }
    
    class func getAllCities()-> [CitiyModel]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        var citiesData = [CitiyModel]()
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let cityData = CitiyModel()
                cityData.address =   data.value(forKey: "address") as! String
                cityData.longitude =   data.value(forKey: "longitude") as! Double
                cityData.latitude =   data.value(forKey: "latitude") as! Double
                citiesData.append(cityData)
            }
            
        } catch {
            
            print("Failed")
        }
        return citiesData
    }
    
}
