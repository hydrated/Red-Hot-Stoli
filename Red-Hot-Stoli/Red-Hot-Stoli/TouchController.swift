//
//  TouchController.swift
//  Red-Hot-Stoli
//
//  Created by Hydra on 2015/1/18.
//  Copyright (c) 2015年 Hydra. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class TouchController : UIViewController {
    @IBOutlet weak var outletButtonHeart: UIImageView!
    @IBOutlet weak var outletHeartBackground: UIImageView!
    
    
    var isTouched :Bool = false
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTagRecognizer()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        isTouched = false
        doHeartBeatAnimationWithRate(1.2)
    }
    
    func playHeartBeatAudio() {
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("跳動音效", ofType: "mp3")!)
        
        // Removed deprecated use of AVAudioSessionDelegate protocol
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func registerTagRecognizer() {
        var tagRecog :UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onHeartTag")
        outletButtonHeart.userInteractionEnabled = true
        outletButtonHeart.addGestureRecognizer(tagRecog)
    }
    
    func onHeartTag() {
        if !isTouched {
            NSLog("on tag")
            isTouched = true
            
            playHeartBeatAudio()
            doHeartBeatAnimationWithRate(0.35)
            var time = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "toNextController", userInfo: nil, repeats: false)
        }
    }
    
    func doHeartBeatAnimationWithRate(rate :NSTimeInterval) {
        outletButtonHeart.stopAnimating()
        var imgArrays :NSMutableArray = []
        var image1 :UIImage! = UIImage(named: "跳動心_大.png")
        var image2 :UIImage! = UIImage(named: "跳動心_小.png")
        imgArrays.addObject(image1)
        imgArrays.addObject(image2)
        
        outletButtonHeart.animationImages = imgArrays
        outletButtonHeart.animationDuration = rate;
        outletButtonHeart.animationRepeatCount = 0;
        outletButtonHeart.startAnimating()
        
        
        outletHeartBackground.stopAnimating()
        var imgArraysBackground :NSMutableArray = []
        var imageBack1 :UIImage! = UIImage(named: "開始愛心底.png")
        var imageBack2 :UIImage! = UIImage(named: "開始愛心底大.png")
        
        imgArraysBackground.addObject(imageBack1)
        imgArraysBackground.addObject(imageBack2)
        
        outletHeartBackground.animationImages = imgArraysBackground
        outletHeartBackground.animationDuration = rate;
        outletHeartBackground.animationRepeatCount = 0;
        outletHeartBackground.startAnimating()
    }
    
    
    func toNextController() {
        let vc :UIViewController! = self.storyboard?.instantiateViewControllerWithIdentifier("HeartRateController") as UIViewController
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(vc, animated: true, completion: nil)
        audioPlayer.stop()
    }
    //    override func viewDidAppear(animated: Bool) {
    //        super.viewDidAppear(animated)
    //        openWinStoryBoard()
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}