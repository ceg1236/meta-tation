//
//  OptionsContainerViewController.swift
//  Meta-tation
//
//  Created by Carl Goldberg on 2/25/15.
//  Copyright (c) 2015 Tangent Circles. All rights reserved.
//

import UIKit

class OptionsContainerViewController: UIViewController {
    
    var readyToStart:Bool = false
    
    @IBOutlet var sessionTime: UIDatePicker!
    @IBOutlet var sessionType: UISegmentedControl!
    @IBOutlet var sessionButton: UIButton!
    var timer:NSTimer = NSTimer()
    var endTime: NSDate = NSDate()
    
    
    
    func updateCountdown() {
        var value = round(endTime.timeIntervalSinceNow)
        var text = Utils.countDownTextFromSeconds(Int(value))
        println(text)
    }
    @IBAction func expandOptionsContainer(sender: AnyObject) {
        
        if readyToStart {
            
            println(self.sessionType.selectedSegmentIndex)
            
            
            timer.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateCountdown"), userInfo: nil, repeats: true)
            var totalTime =  self.sessionTime.date
            var comps: NSDateComponents = NSCalendar.currentCalendar().components((.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond), fromDate: totalTime)
            
            self.endTime = NSDate().dateByAddingTimeInterval(NSTimeInterval(comps.hour*3600+comps.minute*60+comps.second))
        
            
        } else {
            sessionButton.setTitle("Start Session", forState: .Normal)
            
            var parent = self.parentViewController as? ViewController
            if parent != nil {
                parent!.expandContainerToShowOptions()
            }
            self.readyToStart = true
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
