//
//  ViewController.swift
//  test
//
//  Created by 薛焱 on 16/3/10.
//  Copyright © 2016年 薛焱. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hud: UIActivityIndicatorView!
    @IBOutlet weak var someView: UIView!
    var replicatorLayer = CAReplicatorLayer()
    var instanceLayer = CALayer()
    var faderAnimation: CABasicAnimation!
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.startAnimating()
        
        replicatorLayer.frame = someView.bounds
        
//        let count: Int = 30
        
//        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(Float(M_PI * 2.0) / Float(count)), 0.0, 0.0, 1.0)
//        replicatorLayer.preservesDepth = false
        replicatorLayer.instanceColor = UIColor.grayColor().CGColor
        
//        replicatorLayer.instanceRedOffset = 0.0
//        replicatorLayer.instanceGreenOffset = 0.0
//        replicatorLayer.instanceBlueOffset = 0.0
//        replicatorLayer.instanceAlphaOffset = 0.0
        
        
        someView.layer.addSublayer(replicatorLayer)
        
        
        let layerWidth: CGFloat = 10.0
        let midX = CGRectGetMidX(someView.bounds) - layerWidth / 2
        instanceLayer.frame = CGRect(x: midX, y: 0.0, width: layerWidth, height: layerWidth * 2.5)
        instanceLayer.backgroundColor = UIColor.whiteColor().CGColor
        replicatorLayer.addSublayer(instanceLayer)
        
    }
    
    @IBAction func slider(sender: UISlider) {
        let count: Int = Int(sender.value * 30)
        replicatorLayer.instanceCount = count
        if sender.value == 1 {
            replicatorLayer.instanceDelay = CFTimeInterval(1.0 / Double(count))
            addAnimation()
        }else{
            if faderAnimation != nil {
                instanceLayer.opacity = 1.0
               instanceLayer.removeAnimationForKey("fader")
            }
            
        }
        
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(Float(M_PI * 2.0) * sender.value / Float(count)), 0.0, 0.0, 1.0)
    }
    func addAnimation() {
        faderAnimation = CABasicAnimation(keyPath: "opacity")
        faderAnimation.fromValue = 1.0
        faderAnimation.toValue = 0.0
        faderAnimation.duration = 1
        faderAnimation.repeatCount = Float(Int.max)
        instanceLayer.opacity = 0.0
        instanceLayer.addAnimation(faderAnimation, forKey: "fader")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

