//
//  ViewController.swift
//  Cloest-Beacon
//
//  Created by boran wang on 2017-05-24.
//  Copyright © 2017 boran wang. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    //MARK: Properties:
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var messageLabel: UILabel!
    
    let locationManger = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Estimotes")
    let colors = [
        31059: UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
        38948: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
        47861: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
    ]
    let messageText = [
        31059: "That I first saw your lovely face, Now I see it every day.                                           🌕🌖🌗🌘🌑🌒🌓🌔                   Good Morning and Evening. ",
        38948: "That I am, I am, I am, the luckiest.   😍😘😜 Eat well ! ",
        47861: "And in a wide sea of eyes,🌹                    I see one pair that I recognize.                Happy Makeup!💅"
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
            self.messageLabel.text = self.messageText[cloestBeacon.minor.intValue]
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
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        nameLabel.text = "Send hitted"
    }


}

