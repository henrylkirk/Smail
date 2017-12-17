//
//  ViewController.swift
//  Smail
//
//  Created by Henry Kirk on 12/2/17.
//  Copyright © 2017 Henry Kirk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var envelopeBackTop: UIImageView!
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var letterView : LetterView!
    var sealed : Bool = false // is the letter sealed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        letterView?.backgroundColor = UIColor.blue
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
        // toggle between icons
        if(sealed){
            sender.image = UIImage(named: "envelope_closed")
            sealed = false
        } else {
            sender.image = UIImage(named: "envelope")
            sealEnvelope()
        }
    }
    
    // Animate the letter view vertically
    func sealEnvelope(){
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
            })
        })
        sealed = true
    }
    
    // Animate the letter view vertically
    func unsealEnvelope(){
    }
    
}
