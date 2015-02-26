//
//  Utils.swift
//  Meta-tation
//
//  Created by Carl Goldberg on 2/25/15.
//  Copyright (c) 2015 Tangent Circles. All rights reserved.
//

import UIKit

class Utils {
    class func countDownTextFromSeconds(value: NSInteger) -> NSString{
        var res = ""
        var hours = value/3600
        var minutes:Int = (value/60)%60
        var seconds = value%60
        
        
        if(hours > 0){
            if(hours < 10){
                res += "0"
            }
            res += "\(hours)h "
        }
        if(minutes > 0){
            if(minutes < 10){
                res += "0"
            }
            res += "\(minutes)m "
        }
        
        res += "\(seconds)s"
        
        return res
        
    }
}
