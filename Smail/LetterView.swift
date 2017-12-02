//
//  LetterView.swift
//  Smail
//
//  Created by Henry Kirk on 12/2/17.
//  Copyright © 2017 Henry Kirk. All rights reserved.
//

import UIKit

class LetterView: UIView {
    
    var layers:[Array<CGPoint>] = []
    var layerIndex = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        print("init(coder:) called")
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // Drawing code
    override func draw(_ rect: CGRect) {
        // get pointer to view
        let context = UIGraphicsGetCurrentContext()
        context?.clear(rect)
        
        // change view background color to white
        UIColor.white.setFill()
        UIRectFill(rect)
        // set pen color to black
        UIColor.black.set()
        // set the line width to 4
        context?.setLineWidth(4.0)
        
        // loop through the layers if any
        for points in layers {
            // loop through each layer's point values
            if points.count - 1 > 0 {
                for i in 0 ..< points.count-1{
                    let pt1 = points[i] as CGPoint
                    let pt2 = points[i+1] as CGPoint
                    context?.move(to: pt1)
                    context?.addLine(to: pt2)
                    context?.strokePath()
                }
            }
        }
    }
    
    // On new touch, start a new array (layer) of points
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var points:[CGPoint] = []
        layers.append(points)
        let pt = (touches.first!).location(in: self)
        points.append(pt)
        self.setNeedsDisplay()
    }
    
    // Add each point to the correct array as the finger moves
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pt = (touches.first!).location(in: self)
        layers[layerIndex].append(pt)
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("layer \(layerIndex) now has \(layers[layerIndex].count) ")
        layerIndex += 1
        self.setNeedsDisplay()
    }
    
    func createImageFromContext() -> UIImage {
        print("createImageFromContext - dump view contents to image")
        let contextRect = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        UIGraphicsBeginImageContext(contextRect.size)
        //get whatever the user drew in the view
        layer.render(in: UIGraphicsGetCurrentContext()!)
        //create new image with it
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage!
    }
    
    // Clear drawing
    func clear() {
        print("Clear the screen")
        // next layer starts at zero
        layerIndex = 0
        // reset the array
        layers.removeAll()
        // update the view
        setNeedsDisplay()
    }
    
}
