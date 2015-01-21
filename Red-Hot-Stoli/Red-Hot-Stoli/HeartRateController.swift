//
//  HeartRateController.swift
//  Red-Hot-Stoli
//
//  Created by Hydra on 2015/1/18.
//  Copyright (c) 2015年 Hydra. All rights reserved.
//

import Foundation
import UIKit

class HeartRateController : UIViewController {
    @IBOutlet weak var outletLabelHeartRate: UILabel!
    @IBOutlet weak var outletImageHeartBeat: UIImageView!
    var myTimer :NSTimer?
    var myFloatAlpha :CGFloat = 0.3
    

    @IBAction func actionButtonBack(sender: AnyObject) {
        if let tmpTimer = myTimer {
            tmpTimer.invalidate()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        myTimer
            = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "stepNumberGenerate", userInfo: nil, repeats: true)
        var stopTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("stopTimer"), userInfo: nil, repeats: false)
        
        self.view.bringSubviewToFront(outletLabelHeartRate)
        
    }
    
    
    func stepNumberGenerate() {

        let myHeartRate = random() % 35 + 85
        outletLabelHeartRate.text = myHeartRate.description
    }
    
    func stopTimer() {
        if let timer = myTimer {
            timer.invalidate()
            doHeartBeatAnimationWithRate(1.0)

        }
    }
    
    
    func doHeartBeatAnimationWithRate(rate :NSTimeInterval) {
        outletImageHeartBeat.stopAnimating()
        var imgArrays :NSMutableArray = []
        var image1 :UIImage! = UIImage(named: "跳動心_大.png")
        var image2 :UIImage! = UIImage(named: "跳動心_小.png")
        imgArrays.addObject(image1)
        imgArrays.addObject(image2)
        
        outletImageHeartBeat.animationImages = imgArrays
        outletImageHeartBeat.animationDuration = rate;
        outletImageHeartBeat.animationRepeatCount = 0;
        outletImageHeartBeat.startAnimating()
    }
    
    
}