//
//  ViewController.swift
//  Smail
//
//  Created by Henry Kirk on 12/2/17.
//  Copyright © 2017 Henry Kirk. All rights reserved.
//

import UIKit

class LetterVC: UIViewController {
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var envelopeBackTop: UIImageView!
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var letterView : LetterView!
    var sealed : Bool = false // is the letter sealed?
    var letterOriginalY: CGFloat = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        letterOriginalY = letterView!.frame.origin.y
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Called when "share" button pressed
    @IBAction func sharePicture() {
        let image = letterView.createImageFromContext()
        let message = "Here's a great drawing!"
        let postItems = [message,image] as [Any]
        let activityVC = UIActivityViewController(activityItems: postItems, applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    // When "trash" button pressed, delete the letter
    @IBAction func deleteLetter() {
        letterView?.clear()
    }
    
    // Called when "envelope" button pressed
    @IBAction func sealEnvelope(_ sender: UIBarButtonItem) {
        self.letterView.translatesAutoresizingMaskIntoConstraints = true // to change position despite autolayout
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            // Move letter up
            self.letterView!.frame.origin.y += -250
        }, completion: { (success:Bool) in
            // Bring envelope image to front
            self.rootView.bringSubview(toFront: self.envelopeBackTop)
            self.rootView.bringSubview(toFront: self.toolbar)
            // Move letter into envelope
            UIView.animate(withDuration: 1.0, animations: {
                self.letterView!.frame.origin.y += self.letterView.frame.height + 60
            }, completion: { (success:Bool) in
                // Show EnvelopeVC
                self.performSegue(withIdentifier: "showEnvelope", sender: nil)
                // Reset letter position and z-order
                self.letterView!.frame.origin.y = self.letterOriginalY
                self.rootView.bringSubview(toFront: self.letterView)
                self.rootView.bringSubview(toFront: self.toolbar)
            })
        })
        sealed = true
    }
    
    // Animate the letter to come out of envelope
    func unsealEnvelope(){
//        self.letterView.translatesAutoresizingMaskIntoConstraints = true // to change position despite autolayout
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
//            // Move letter up
//            self.letterView!.frame.origin.y += -250
//        }, completion: { (success:Bool) in
//            // Bring envelope image to front
//            self.rootView.bringSubview(toFront: self.envelopeBackTop)
//            self.rootView.bringSubview(toFront: self.toolbar)
//            // Move letter into envelope
//            UIView.animate(withDuration: 1.0, animations: {
//                self.letterView!.frame.origin.y += self.letterView.frame.height + 60
//            }, completion: { (success:Bool) in
//                // Show EnvelopeVC
//                self.performSegue(withIdentifier: "showEnvelope", sender: nil)
//            })
//        })
//        sealed = false
    }
    
}
