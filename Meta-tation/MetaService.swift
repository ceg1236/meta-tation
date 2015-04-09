//
//  MetaService.swift
//  Meta-tation
//
//  Created by Carl Goldberg on 2/27/15.
//  Copyright (c) 2015 Tangent Circles. All rights reserved.
//

import UIKit

var metaService: MetaService?

class MetaService {

//  Singleton pattern
    
    class func getInstance() -> MetaService {
        if !(metaService != nil) {
            metaService = MetaService(urlString:"http://localhost:8003")
        }
        
        return metaService!
    }
    
    let urlString:String

    var user:User?
    
    private init(urlString:String){
        self.urlString = urlString
        
        handshake(User(), handler:({
            (user: User) -> Void in
            
            println("shaking hands")
            println(user.id)
            
            self.user = user
        }))
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
    
    
    func postSession(handler: (User?) -> Void) {
        println("start POSTing")
        if self.user != nil {
            
            var routeString: String = urlString + "/api/sessions/"
            let url = NSURL(string: routeString)
            var request = NSMutableURLRequest(URL: url!)
            
            request.HTTPMethod = "POST"
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
                
                var casted = response as NSHTTPURLResponse
                
                if error != nil {
                    println("Error in posting a session")
                    println(error)
                    return
                }
                
                if data != nil {
                    println("fresh POST data here")
                    println(casted.statusCode)
                    
                    if casted.statusCode >= 300 {
                        println("Status code \(casted.statusCode)")
                        handler(nil)
                    } else {
                        handler(self.user?)
                    }
                    
                }

            }
        } else {
            println("User did not introduce himself before POSTing")
        }
    }
}

