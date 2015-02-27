//
//  OptionsContainerViewController.swift
//  Meta-tation
//
//  Created by Carl Goldberg on 2/25/15.
//  Copyright (c) 2015 Tangent Circles. All rights reserved.
//

import UIKit

class OptionsContainerViewController: UIViewController {
    
//    var readyToStart:Bool = false
//    var readyToEnd:Bool = false
    
    enum SessionState: Int {
        case Idle
        case ReadyToStart
        case Counting
    }
    var sessionState: SessionState = .Idle
    
    @IBOutlet var sessionTime: UIDatePicker!
    @IBOutlet var sessionType: UISegmentedControl!
    @IBOutlet var sessionButton: UIButton!
    @IBOutlet var countDownLabel: UILabel!
    var timer:NSTimer = NSTimer()
    var endTime: NSDate = NSDate()
    
    func sessionEnd() {
        timer.invalidate()
        self.countDownLabel.hidden = true
        self.sessionTime.hidden = false
        Utils.alert("Session Finished", text: "Namaste", controller: self)
        self.sessionButton.setTitle("Start Session", forState: .Normal)
        self.sessionState = .ReadyToStart
        
    }
    
    func updateCountdown() {
        var value = round(endTime.timeIntervalSinceNow)
        if value <= 0 {
            sessionEnd()
//            value = 0
        }
        var text = Utils.countDownTextFromSeconds(Int(value))
        countDownLabel.text = text
        println(text)
    }
    @IBAction func expandOptionsContainer(sender: AnyObject) {
        
        if sessionState == .Counting {
            
            sessionEnd()
            
        } else if sessionState == .ReadyToStart {
            
            println(self.sessionType.selectedSegmentIndex)
            
            
            timer.invalidate()
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateCountdown"), userInfo: nil, repeats: true)
            var totalTime =  self.sessionTime.date
            var comps: NSDateComponents = NSCalendar.currentCalendar().components((.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond), fromDate: totalTime)
            
            self.endTime = NSDate().dateByAddingTimeInterval(NSTimeInterval(comps.hour*3600+comps.minute*60+comps.second))
            
            sessionButton.setTitle("End Session", forState: .Normal)
            
            self.sessionTime.hidden = true
            self.updateCountdown()
            self.countDownLabel.hidden = false
            self.sessionState = .Counting
        
            
        } else {    // sessionState.Idle
            
            sessionButton.setTitle("Start Session", forState: .Normal)
            
            var parent = self.parentViewController as? ViewController
            if parent != nil {
                parent!.expandContainerToShowOptions()
            }
            self.sessionState = .ReadyToStart
//            self.readyToStart = true
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countDownLabel.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
