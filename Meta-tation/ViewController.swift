//
//  ViewController.swift
//  Meta-tation
//
//  Created by Carl Goldberg on 2/17/15.
//  Copyright (c) 2015 Tangent Circles. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var tsongaMap: MKMapView!
    @IBAction func startSession(sender: AnyObject) {
        
    }
    
    var lat:CLLocationDegrees = 37.7836449
    var lng:CLLocationDegrees = -122.4091387
    
    var latDelta:CLLocationDegrees = 0.1
    var lngDelta:CLLocationDegrees = 0.1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Snippet for extracting JSON with SwiftyJSON
        let url = NSURL(string: "http://localhost:8003/meditators")
        var request = NSURLRequest(URL: url!)
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        if data != nil {
            var hoge = JSON(data: data!)
            println(hoge)
            
            var latlng = hoge[0]["latlng"]
            println(latlng)
            
            if latlng != nil {
                lat = latlng[0].double!
                lng = latlng[1].double!
                
                latDelta = 0.01
                lngDelta = 0.01

            }
            
            var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lngDelta)
            
            var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lng)
            
            var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            tsongaMap.setRegion(region, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

