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
import Firebase
import FirebaseDatabase
// this is my main view controler class here my map is set and pins are added//
class ViewController: UIViewController, CLLocationManagerDelegate {
    var pins : [Pin] = []
    
    
    var longitude: [Double] = []
    var latitude: [Double] = []
    var titlePin: [String] = []
    var subtitle: [String] = []
    var slider = 50
    var pinsLength=0
    let locationManager = CLLocationManager()
    var pinType:String? = ""
    var pinQuality:Double? = 9.0
    let current = UserDefaults.standard
    var timeTest=0
    
    @IBOutlet weak var rangeSlider: UISlider!

    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func rangeSliderChanged(_ sender: UISlider) {
        slider=Int(sender.value)
        refresh()
    }
    @IBAction func refreshClicked(_ sender: Any) {
        //image link-https://support.flaticon.com/hc/en-us/articles/207248209-How-I-must-insert-the-attribution-    https://www.google.com/search?safe=strict&rlz=1C5CHFA_enUS746US746&biw=1440&bih=652&tbm=isch&sa=1&q=earth+image+png&oq=earth+image+png&gs_l=psy-ab.3..0.41096.41406.0.41533.3.3.0.0.0.0.83.224.3.3.0....0...1.1.64.psy-ab..0.3.223...0i30k1j0i8i30k1.tadJkuQ6CO4#imgrc=aa9wXhL915TdmM:
        let imageName = "earth.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.image = image
        imageView.frame = CGRect(x: 168, y: 268, width: 50, height: 50)
        self.view.addSubview(imageView)
        
        imageView.rotate360Degrees()
        refresh()
        if(timeTest==1){
            imageView.removeFromSuperview()
        }
        
    }
    override func viewDidLoad() {   
        super.viewDidLoad()
        
//        DispatchQueue.main.async {
        self.retrieveFromFire() { (success) in
            if success {
                self.pinsLength=self.pins.count
                
                self.locationManager.delegate = self
                self.locationManager.startUpdatingLocation()
                
                let coordinateCenter = self.locationManager.location!.coordinate
                let latCenter = Double(coordinateCenter.latitude)
                let longCenter = Double(coordinateCenter.longitude)
                
                if(self.pinsLength==0){
                    
                }
                else{
                for i in 0...self.pinsLength-1{
                    
                    self.longitude.append(self.pins[i].longitude!)
                    
                    self.latitude.append(self.pins[i].latitude!)
                    
                    self.titlePin.append(self.pins[i].title!)
                    
                    self.subtitle.append(self.pins[i].subtitle!)
                }
                for x in 0...self.pinsLength-1{
                    let distanceX = longCenter-self.longitude[x]
                    let powerX = pow(distanceX,2.0)
                    let distanceY = latCenter-self.latitude[x]
                    let powerY = pow (distanceY,2.0)
                    if(x==self.pinsLength-1){
                        self.timeTest=1
                    }
                    if(powerX+powerY<=0.000298)   {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(latitude: self.latitude[x], longitude: self.longitude[x])
                        annotation.title = self.titlePin[x]
                        if(self.subtitle[x]=="10.0"){
                            annotation.subtitle = ("Quality:no ratings")
                        }
                        else{
                        annotation.subtitle = ("Quality:\(self.subtitle[x])")
                        }
                        self.mapView.addAnnotation(annotation)
                    }
                    else{
                        
                    }
                    }
                }
            }
        }
 
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
//            print(self.pins)
//        }
        
        
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
            
            

            
            
            mapView.setRegion(MKCoordinateRegionMakeWithDistance(coordinate, 500, 500), animated: true)
            retrieveNumbersFromCreatePinClass()
        
        
            if(pinQuality==9.0){
            }
            else if(pinType==""){
                
            }
                
            else{
                let coordinate = locationManager.location!.coordinate
                let lat = Double(coordinate.latitude)
                let long = Double(coordinate.longitude)
                let dictLocation: [AnyHashable : Any] = ["Latitude": lat, "Longitude": long]
                current.set(dictLocation, forKey: "coordinate1")
                var pin = Pin(title:pinType!, subtitle:"Quality:\(pinQuality!)", longitude: long, latitude: lat)
                
                PinService.createPin(longitude: long,latitude:lat, title: pinType!, subtitle:"Quality:\(pinQuality!)", completion:{ (pin) in
                    return
                    })
                
                
                if(pinQuality==10.0){
                    pin = Pin(title:pinType!, subtitle:"Quality:no ratings", longitude: long, latitude: lat)
                }
                else{
                }
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                annotation.title = pinType!
                annotation.subtitle = ("Quality:\(pinQuality!)");
                mapView.addAnnotation(annotation)
                pinQuality=9.0
                //creating the pin
            }
        
}


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func waitForPins() {
        DispatchQueue.main.async {
//            self.retrieveFromFire()
    
        }
    }
    
    func retrieveNumbersFromCreatePinClass(){               //func to retrive from the segments in the createMarkClass
        pinType=(UserDefaults.standard.object(forKey: "segmentType") as! String? ?? "")
        pinQuality=(UserDefaults.standard.object(forKey: "Quality") as! Double? ?? 9.0)
        
    }

    @IBAction func createPressed(_ sender: Any) {
        
        UserDefaults.standard.set(9.0, forKey: "Quality")
        UserDefaults.standard.set("", forKey: "segmentType")
        performSegue(withIdentifier: "CreatePressed", sender: self)
    }
    func retrieveFromFire(success: @escaping (Bool) -> Void) {
        let dispatcher = DispatchGroup()
        dispatcher.enter()
        PinService.show() { (pin) in
            if let pin = pin{
                self.pins = pin
                dispatcher.leave()
            }
            else{
                print("not working")
                return
            }
        }
        dispatcher.notify(queue: .main) {
            success(true)
        }
    }
    
    func refresh(){
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.removeAnnotations(mapView.annotations)
        self.pinsLength=self.pins.count
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        let coordinateCenter = self.locationManager.location!.coordinate
        let latCenter = Double(coordinateCenter.latitude)
        let longCenter = Double(coordinateCenter.longitude)
        
        if(self.pinsLength==0){
            
        }
        else{
            for x in 0...self.pinsLength-1{
                let distanceX = longCenter-self.longitude[x]
                let powerX = pow(distanceX,2.0)
                let distanceY = latCenter-self.latitude[x]
                let powerY = pow (distanceY,2.0)
                if(powerX+powerY<=0.000149*Double(slider))   {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: self.latitude[x], longitude: self.longitude[x])
                    annotation.title = self.titlePin[x]
                    if(self.subtitle[x]=="10.0"){
                        annotation.subtitle = ("Quality:no ratings")
                    }
                    else{
                        annotation.subtitle = ("Quality:\(self.subtitle[x])")
                    }
                    self.mapView.addAnnotation(annotation)
                }
                else{
                    print("not in range")
                }
            }
            self.pinsLength=self.pins.count
            
            self.locationManager.delegate = self
            self.locationManager.startUpdatingLocation()
            let coordinateCenter = self.locationManager.location!.coordinate
            
            
             mapView.setRegion(MKCoordinateRegionMakeWithDistance(coordinateCenter, 10+(10*Double(slider)),10+(10*Double(slider))), animated: true)
        }
    }

    }
extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as! CAAnimationDelegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
        


    }
}
