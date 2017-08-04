//
//  PinService.swift
//  ExploreWorld_1.0
//
//  Created by Kevin W on 7/28/17.
//  Copyright © 2017 Kevin W. All rights reserved.
//

import Foundation
import FirebaseDatabase
import MapKit
struct PinService{
    
    static func createPin(longitude:Double,latitude:Double,title:String,subtitle:String, completion: @escaping (Pin?) -> Void){
        
        
        let refOne = Database.database().reference().child("pins").child(User.current.uid).childByAutoId()
        
        let arrPin=["longitude":longitude,
                    "latitude":latitude,
                    "subtitle":subtitle,
                    "title":title] as [String : Any]
    
        refOne.setValue(arrPin) { (error, refOne) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            refOne.observeSingleEvent(of: .value, with: { (snapshot) in
                let pin = Pin(snapshot: snapshot)
                completion(pin)
            })
            
            
        }
    
        
    
    }
    static func createPinAll(longitude:Double,latitude:Double,title:String,subtitle:String, completion: @escaping (Pin?) -> Void){
        
        let refTwo = Database.database().reference().child("allPins").childByAutoId()
        
        let arrPin=["longitude":longitude,
                    "latitude":latitude,
                    "subtitle":subtitle,
                    "title":title] as [String : Any]
        refTwo.setValue(arrPin) { (error, refOne) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            refTwo.observeSingleEvent(of: .value, with: { (snapshot) in
                let pin = Pin(snapshot: snapshot)
                completion(pin)
            })
        }
        
        
        
    }

        
        
    
    static func showAll(completion: @escaping ([Pin]?) -> Void) {
        
    
        let ref = Database.database().reference().child("allPins")
        
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion(nil)
                
            }
            var items : [Pin] = []
            for item in snapshot {
                if let pin = Pin(snapshot: item) {
                    items.append(pin)
                }
            }
            completion(items)
        }
        )}
    
    
    


    static func showOne(completion: @escaping ([Pin]?) -> Void) {
        
        
        let refId = Database.database().reference().child("pins")
        print(refId)
        
        
        let ref = Database.database().reference().child("pins").child(User.current.uid)
        print(ref)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
              return completion(nil)
                
            }
            var items : [Pin] = []
            for item in snapshot {
                if let pin = Pin(snapshot: item) {
                    items.append(pin)
                }
            }
            completion(items)
        }
        )}

    
    
}
