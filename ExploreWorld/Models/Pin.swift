//
//  Pin.swift
//  ExploreWorld_1.0
//
//  Created by Kevin W on 7/25/17.
//  Copyright © 2017 Kevin W. All rights reserved.
//

import Foundation
import MapKit
    //this is my class to create a format to create pins used in the main view controller//
class Pin: NSObject,MKAnnotation{
    var title: String?
    var subtitle:String?
    var coordinate: CLLocationCoordinate2D
    
    init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D){
        self.title=title
        self.subtitle=subtitle
        self.coordinate=coordinate
    }
}
