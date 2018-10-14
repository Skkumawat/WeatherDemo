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
    
    class func saveAddressData(locationData: LocationModel) {
        let location = Address(context: context)
        
        location.address = locationData.address
        location.latitude = locationData.latitude
        location.longitude = locationData.longitude
        appdelgate.saveContext()
    }
    
    class func deleteAllCitiesData(entityName: String, completionHandler: @escaping (_ success: Bool) -> ()) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        fetchRequest.returnsObjectsAsFaults = false
        
        let result = try? context.fetch(fetchRequest)
        
        for object in result! {
            context.delete(object as! NSManagedObject)
        }
        completionHandler(true)
        appdelgate.saveContext()
    }
    
    class func getAllCities(completionHandler: @escaping ([LocationModel]) -> ()){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Address")
        request.returnsObjectsAsFaults = false
        var LocationsData = [LocationModel]()
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let locationData = LocationModel()
                locationData.address =   data.value(forKey: "address") as! String
                locationData.longitude =   data.value(forKey: "longitude") as! Double
                locationData.latitude =   data.value(forKey: "latitude") as! Double
                LocationsData.append(locationData)
            }
            completionHandler(LocationsData)
            
        } catch {
            
            print("Failed")
        }
    }
    
    class func deleteLocation(location: LocationModel) {
        if let locationData = getUsersByAddress(address: location.address) {
            context.delete(locationData)
        }
         appdelgate.saveContext()
    }
    
    class func getUsersByAddress(address: String)-> NSManagedObject?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Address")
        request.predicate = NSPredicate(format: "address == %@", address)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                return data
            }
        } catch {
            
            print("Failed")
        }
        return nil
    }
    
}
