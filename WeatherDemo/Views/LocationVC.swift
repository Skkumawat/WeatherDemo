//
//  LocationVC.swift
//  WeatherDemo
//
//  Created by Sharvan  Kumawat on 10/12/18.
//  Copyright © 2018 Sharvan. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController {

    static func storyboardInstance() -> LocationVC {
        return Storyboard.kMainStoryboard.instantiateViewController(withIdentifier: LocationVC.stringRepresentation) as! LocationVC
    }
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnSaveLocation: UIButton!
    
    fileprivate var locationManager: CLLocationManager!
    let city = CitiyModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ScreenTitle.location.rawValue
        
        setCurrentLocation()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(userPerformedLongPress(gesture:)))
        longPressGesture.minimumPressDuration = 1.0
        self.mapView.addGestureRecognizer(longPressGesture)
        
        // Do any additional setup after loading the view.
    }

    func setCurrentLocation(){
        if (CLLocationManager.locationServicesEnabled()) {
            if locationManager == nil {
                locationManager = CLLocationManager()
            }
            locationManager?.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    @objc func userPerformedLongPress(gesture: UIGestureRecognizer) {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        
        let touchPoint = gesture.location(in: mapView)
        let newCoordinate: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinate
        annotation.title = "Selected Location"
        
        annotation.subtitle = "Coordinate: \(round(1000*newCoordinate.longitude)/1000), \(round(1000*newCoordinate.latitude)/1000)"
       
        mapView.addAnnotation(annotation)
        
        let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
        
        LocationManager.getAddressFromLatitudeLongitude(location: location) { address in
            self.city.address = address!
            self.city.latitude = newCoordinate.latitude
            self.city.longitude = newCoordinate.longitude
            self.lblLocation.text = "latitude: \(newCoordinate.latitude) \nlongitude: \(newCoordinate.longitude) \nAddress: \(address ?? "")"
        }
        
    }
    
    @IBAction func btnSavePressed(){
        CoreDataManager.saveAddressData(cityData: city)
        
        self.navigationController?.popViewController(animated: true)

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

// MARK: - CLLocationManagerDelegate
extension LocationVC: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            //manager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.mapView.setRegion(region, animated: true)
            
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = location.coordinate
            pointAnnotation.title = ""
            mapView.addAnnotation(pointAnnotation)
            
            LocationManager.getAddressFromLatitudeLongitude(location: location) { address in
                
                self.city.address = address!
                self.city.latitude = location.coordinate.latitude
                self.city.longitude = location.coordinate.longitude
                
                self.lblLocation.text = "latitude: \(location.coordinate.latitude) \nlongitude: \(location.coordinate.longitude) \nAddress: \(address ?? "")"
            }
        }
        locationManager.stopUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
