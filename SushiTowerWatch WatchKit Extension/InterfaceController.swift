//
//  InterfaceController.swift
//  SushiTowerWatch WatchKit Extension
//
//  Created by Shikhar Shah on 2019-10-30.
//  Copyright © 2019 Lambton. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import UIKit
class InterfaceController: WKInterfaceController, WCSessionDelegate{
    
    
    var pauseFlag = false
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    

    @IBOutlet weak var btnPause: WKInterfaceButton!
  
    @IBAction func onPauseTapped() {
        if(pauseFlag == true)
        {
            print("TRUE")
            pauseFlag = false
            let message = ["message" : "resume"] as! [String: Any]
            WCSession.default.sendMessage(message, replyHandler: nil)
            btnPause.setTitle("Pause")
        }
        else if(pauseFlag == false){
            print("FALSE")
            let message = ["message" : "pause"] as! [String: Any]
            WCSession.default.sendMessage(message, replyHandler: nil)
             btnPause.setTitle("Resmue")
            pauseFlag = true
        }
        
       
    }
    
    @IBOutlet weak var labelTimer: WKInterfaceLabel!
    
    @IBOutlet weak var btnPowerup: WKInterfaceButton!
  
    @IBOutlet weak var labelPowerup: WKInterfaceLabel!

    @IBAction func onPowerUpTapped() {
        print("Click")
        let message = ["message" : "click"] as! [String: Any]
        WCSession.default.sendMessage(message, replyHandler: nil)

    }
    var direction: String = ""
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        let session = WCSession.default
        session.delegate = self
        session.activate()

        self.btnPowerup.setHidden(true)
        if(pauseFlag)
        {
        btnPause.setTitle("Resume")
        }
        else{
            btnPause.setTitle("Pause")
        }
    }
    func handleTap(gestureRecognizer: WKGestureRecognizer) {
       print("Clicked on powerup")
    }
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func onRightPressed() {
        print("Sending RIGHT Data")
        let message = ["message" : "right"] as! [String: String]
        WCSession.default.sendMessage(message, replyHandler: nil)

        
    }
    
    
    @IBAction func onLeftPressed() {
        print("Sending LEFT Data")
        let message = ["message" : "left"] as! [String: String]
        WCSession.default.sendMessage(message, replyHandler: nil)
    }
    

    func session(_ session: WCSession, didReceiveMessage messageData: [String : Any])
    {
        var powerup:String = messageData["powerup"] as! String
        let timeLeft:String = messageData["time"] as! String

        print(powerup)
        if(powerup != "NA" )        {
             btnPowerup.setHidden(false)
            btnPowerup.setTitle(powerup)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.btnPowerup.setHidden(true)
            }
        }
        else{
            btnPowerup.setHidden(true)
        }
        if(timeLeft != "100"){

            if(timeLeft == "0"){
                labelTimer.setTextColor(UIColor.red)
                labelTimer.setText("GAME OVER")
            }
            else{
                labelTimer.setText("\(timeLeft) seconds left")
            }

            
            }
      
        }
    
    
    
}
