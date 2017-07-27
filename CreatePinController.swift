//
//  CreatePinController.swift
//  ExploreWorld_1.0
//
//  Created by Kevin W on 7/25/17.
//  Copyright © 2017 Kevin W. All rights reserved.
//


// This is a class for when the user wants to create a "Mark" or a pin this class uses UserDefaults to transfer the title and subtitle to the main View Controller to create Pins//


import Foundation
import UIKit

class CreatePinController: UIViewController{
    
    var testIfOneTypeIsSelected=0                                             //variable to test if user selected two types
    @IBOutlet weak var typeSegment: UISegmentedControl!
    @IBOutlet weak var otherSegmentType: UITextField!
    
    
    
    
    @IBAction func otherSegmentTypeSelected(_ sender: UITextField) {                //func for when otherType is submitted
        
        UserDefaults.standard.set(otherSegmentType.text, forKey: "segmentType")
        testIfOneTypeIsSelected=testIfOneTypeIsSelected+1
        typeSegment.selectedSegmentIndex=3
    }
    
    
    
    @IBOutlet weak var typeOfMarkSegment: UISegmentedControl!
    
    @IBAction func typeOfMarkSegmentChanged(_ sender: UISegmentedControl) {
        
        switch typeOfMarkSegment.selectedSegmentIndex{
            
        case 0:     //Water Fountain Case
            
            
            UserDefaults.standard.set("Water Fountain", forKey: "segmentType")
            otherSegmentType.text=""
            
            
        case 1:
            
            //Bathroom Case
            
            UserDefaults.standard.set("Bathroom", forKey: "segmentType")
            
            otherSegmentType.text=""
            
            
            
        case 2:
            
            //Statue Case
            
            
            UserDefaults.standard.set("Statue", forKey: "segmentType")
            
            otherSegmentType.text=""
            
            
            
        case 3:
            //Other Case Case
            
            UserDefaults.standard.set(otherSegmentType.text, forKey: "segmentType")
            
        default:
            
            UserDefaults.standard.set("", forKey: "segmentType")
        }
    
    }
    
    
    
    
    
    @IBOutlet weak var qualitySegment: UISegmentedControl!

    @IBAction func qualitySegmentControlChanged(_ sender: UISegmentedControl) {         //func for the quality in the main view controoler I will take the average of them and change the pins subtitle everytime someone edits the pin :)
        
        
        switch qualitySegment.selectedSegmentIndex{
        
        
    case 0:
          //Good Case
        
        
        UserDefaults.standard.set(5.0, forKey: "Quality")
        
        
        
    case 1:
        
        
         //Okay Case
        
        UserDefaults.standard.set(2.5, forKey: "Quality")
        
    case 2:
        
        //Terrible Case
        
        UserDefaults.standard.set(0.0, forKey: "Quality")
        
        
        
        
    case 3:
        
        //not apllicable Cart Case I set it as 10.0 so when in main view controller i wil check if its 10 and if it is i wont calculate it into the average!
        
        UserDefaults.standard.set(10.0, forKey: "Quality")
            
            
    default:
    UserDefaults.standard.set(9.0, forKey: "Quality")
            
        }
    }
    
    
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        let pinQuality=(UserDefaults.standard.object(forKey: "Quality") as! Double? ?? 9.0)
        let pinType=(UserDefaults.standard.object(forKey: "segmentType") as! String? ?? "")
        
        
        if(pinQuality == 9.0){
            error()
        }
        
        else if(pinType == ""){
            error()
        }
        else{
        
        
        dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    
    
    //throws the alert//
    func error(){
        let invalidMoneyAlert = UIAlertController(title: "didnt fill out requirements", message: "please fill out requirements", preferredStyle: UIAlertControllerStyle.alert)
        invalidMoneyAlert.addAction(UIAlertAction(title:"ok", style: UIAlertActionStyle.default,handler:nil))
        self.present(invalidMoneyAlert, animated:true,completion:nil)
    }
   
    
    
    
    
    @IBAction func cancelPressed(_ sender: Any) {
        UserDefaults.standard.set(9.0, forKey: "Quality")
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
}





extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
 
}
