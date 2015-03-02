//
//  MetaService.swift
//  Meta-tation
//
//  Created by Carl Goldberg on 2/27/15.
//  Copyright (c) 2015 Tangent Circles. All rights reserved.
//

import UIKit

class MetaService {
    let urlString:String
    
    init(urlString:String){
        self.urlString = urlString
        
        handshake(User(), handler:({
            (user: User) -> Void in
            
            println("shaking hands")
            println(user.id)
            
        }))
    }

    func getMeditators(handler: ([Meditator]?) -> Void) {

        var routeString:String = urlString + "/meditators"
        let url = NSURL(string: routeString)
        var request = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), { (response, data, error) -> Void in
            
            if error != nil {
                handler(nil)
                return
            }
            
            if data != nil {
                var tsonga = JSON(data: data!)
                var meditatorList: [Meditator] = []
                for (index, json ) in tsonga {
                    meditatorList.append(Meditator(fromJson: json))
                }
                handler(meditatorList)
            }
        })
    }
    
    private func handshake(user: User, handler: (User) -> Void) {
        
        var routeString:String = urlString + "/api/handshake"
        let url = NSURL(string: routeString)
        var request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "POST"
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), { (response, data, error) -> Void in
            
            if error != nil {
                println("Something went wrong with the handshake")
                return
            }
            
            if data != nil {
                println(JSON(data: data!))
                handler(User(fromJson:JSON(data: data!)))
            }

        })
    }
    
    
}

