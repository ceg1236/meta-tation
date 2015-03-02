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


    @IBOutlet var optionsContainerHeight: NSLayoutConstraint!
    
    var lat:CLLocationDegrees = 37.7836449
    var lng:CLLocationDegrees = -122.4091387
    
    var latDelta:CLLocationDegrees = 0.1
    var lngDelta:CLLocationDegrees = 0.1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        optionsContainerHeight.constant = 63
             
        var metaService = MetaService(urlString: "http://localhost:8003")
        metaService.getMeditators({
            (meditators) -> Void in
            
            if meditators == nil {
                Utils.alert("Whoops", text: "Error connecting. Please try again, or simply use the timer without map data", controller: self)
            }
            
            for meditator in meditators! {

                var location = meditator.getLocation()
                var circle:MKCircle = MKCircle(centerCoordinate: location, radius: 20)
                self.tsongaMap.addOverlay(circle)
                
            }

        })
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(self.latDelta, self.lngDelta)
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.lat, self.lng)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.tsongaMap.setRegion(region, animated: true)
        
    }
    
    // TODO: Read this are the changes I made:
    // - instead of viewForOverlay from the delegate, I had to use rendererForOverlay method.
    // - This allowed to create a MKCircleRenderer instead of a MKCircleView. The MKCircleRenderer does accept fillColor (i.e is not deprecated!)
    // - We forgot to make ViewController the delegate for our map. (Fixed by ctrl-dragging the map view in the storyboard to the yellow ViewController circle and selecting "delegate")
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        var circleView:MKCircleRenderer = MKCircleRenderer(overlay: overlay)
        circleView.fillColor = UIColor.redColor()
        return circleView
    }
    
    func expandContainerToShowOptions() {
        println("Expanding")
        self.optionsContainerHeight.constant = 300
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil) // Maybe do a little fun animation on complete
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

