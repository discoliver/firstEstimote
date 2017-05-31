//
//  ViewController.swift
//  Cloest-Beacon
//
//  Created by boran wang on 2017-05-24.
//  Copyright © 2017 boran wang. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, UITextFieldDelegate,CLLocationManagerDelegate {
    
    //MARK: Properties:
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    let locationManger = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Estimotes")
    let colors = [
        31059: UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
        38948: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
        47861: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
        
        locationManger.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse){
            locationManger.requestWhenInUseAuthorization()
        }
        locationManger.startRangingBeacons(in: region)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.unknown}
        if(knownBeacons.count > 0) {
            let cloestBeacon = knownBeacons[0] as CLBeacon
            self.view.backgroundColor = self.colors[cloestBeacon.minor.intValue]
            print("hello")
        }
    }
    
    //MARK: UItextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nameLabel.text = textField.text
    }
    
    //MARK: Actions
    @IBAction func sendMessage(_ sender: UIButton) {
        nameLabel.text = "Send hitted"
    }


}

