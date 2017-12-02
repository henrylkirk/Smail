//
//  ViewController.swift
//  Smail
//
//  Created by Henry Kirk on 12/2/17.
//  Copyright © 2017 Henry Kirk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var letterView : LetterView!
    var sealed : Bool = false // is the letter sealed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        letterView?.backgroundColor = UIColor.blue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            sealed = true
            moveLetter(yTarget: letterView.frame.height-150)
        }
        
        print("image changed")
    }
    
    func moveLetter(yTarget: CGFloat){
        // animate the letter - move down
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            let x = self.letterView!.frame.origin.x
            print("\(x)")
            let location = CGPoint(x: x,y: yTarget)
            self.letterView!.frame.origin = location
        }, completion: nil)
    }
    
}
