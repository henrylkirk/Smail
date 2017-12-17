//
//  EnvelopeVC.swift
//  Smail
//
//  Created by Henry Kirk on 12/16/17.
//  Copyright © 2017 Henry Kirk. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class EnvelopeVC: UIViewController {
    
    @IBOutlet weak var senderCity: UITextField!
    @IBOutlet weak var senderStreetAddress: UITextField!
    @IBOutlet weak var senderName: UITextField!
    var locationManager: CLLocationManager?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            locationManager!.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add gesture for dismissing keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EnvelopeVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // add gesture for opening the envelope on double tap
        let doubletap = UITapGestureRecognizer(target: self, action: #selector(EnvelopeVC.openEnvelope))
        doubletap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubletap)
        
        // Get user's address from location and set as initial sender address
        if let location = locationManager?.location {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location, completionHandler: {placemark,error in
                print("location worked")
                print(location)
                if error == nil {
                    let place = placemark![0]
                    let country = place.isoCountryCode ?? "US"
                    let city = place.locality ?? "Rochester"
                    let zipcode = place.postalCode ?? "14623"
                    let number = place.subThoroughfare ?? "1"
                    let street = place.thoroughfare ?? "Lomb Memorial Dr"
                    let state = place.administrativeArea ?? "NY"
                    
                    // set sender textfield text
                    self.senderCity.text = "\(city), \(state) \(zipcode)"
                    self.senderStreetAddress.text = "\(number) \(street) \(country)"
                }
            })
        }
    }
    
    // Dismiss keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Open the envelope on double tap
    func openEnvelope() {
        self.dismiss(animated: true, completion: nil)
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
