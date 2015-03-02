//
//  Meditator.swift
//  Meta-tation
//  
//  Entity that represents a meditation session.
//
//  Created by Carl Goldberg on 2/28/15.
//  Copyright (c) 2015 Tangent Circles. All rights reserved.
//
import MapKit

class Meditator {
    private var id: Int?
    private var location: CLLocationCoordinate2D
    required init(fromJson:JSON){
        
        var latlng = fromJson["latlng"]
        var lat = latlng[0].double!
        var lng = latlng[1].double!
        
        self.location = CLLocationCoordinate2DMake(lat,lng)
        
    }
    required init(id: Int?, lat: Double, lng: Double){
    
        
        self.location = CLLocationCoordinate2DMake(lat,lng)
        
    }
    func getLocation()->CLLocationCoordinate2D{
        return self.location
    }
}