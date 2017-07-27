//
//  ViewController.swift
//  ExploreWorld_1.0
//
//  Created by Kevin W on 7/24/17.
//  Copyright © 2017 Kevin W. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// this is my main view controler class here my map is set and pins are added//
class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var pinType:String? = ""
    var pinQuality:Double? = 9.0
    let current = UserDefaults.standard
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
            current.synchronize()
            
            
            
            locationManager.delegate = self                                 //code for blue circle and coordinates of user
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            
            
            
            
            
            let coordinate = locationManager.location!.coordinate
            //this is how big the radius of vision is when first opening the app remember its in meters
            
            
            
            //let coordinate1: [AnyHashable : Any] = current.object(forKey: "coordinate1") as! [AnyHashable : Any]
            
            
            
            mapView.setRegion(MKCoordinateRegionMakeWithDistance(coordinate, 500, 500), animated: true)
            retrieveNumbersFromCreatePinClass()
        
        
            if(pinQuality==9.0){
            }
                
                
            else{
                let coordinate = locationManager.location!.coordinate
                let lat = Double(coordinate.latitude)
                let long = Double(coordinate.longitude)
                print(lat)
                let dictLocation: [AnyHashable : Any] = ["Latitude": lat, "Longitude": long]
                current.set(dictLocation, forKey: "coordinate1")
                let coordinateUserRightNow: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
                var pin = Pin(title:pinType!, subtitle:"Quality:\(pinQuality!)", coordinate:coordinateUserRightNow)
                if(pinQuality==10.0){
                    
                    pin = Pin(title:pinType!, subtitle:"Quality:no ratings", coordinate:coordinateUserRightNow)
                }
                else{
                }
                mapView.addAnnotation(pin)
                print("work")
                //creating the pin
            }
        
}


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func retrieveNumbersFromCreatePinClass(){               //func to retrive from the segments in the createMarkClass
        pinType=(UserDefaults.standard.object(forKey: "segmentType") as! String? ?? "")
        pinQuality=(UserDefaults.standard.object(forKey: "Quality") as! Double? ?? 9.0)
        
    }

    @IBAction func createPressed(_ sender: Any) {
        
        UserDefaults.standard.set(9.0, forKey: "Quality")
        performSegue(withIdentifier: "CreatePressed", sender: self)
    }
    
}

