//
//  User.swift
//  Meta-tation
//
//  Entity that represents a meditation User
//
//  Created by Carl Goldberg on 2/28/15.
//  Copyright (c) 2015 Tangent Circles. All rights reserved.
//

class User {
    var id: Int?
    init (){
        // the default, no id!
    }
    init (id: Int){
        self.id = id
    }
    init (fromJson: JSON){
        self.id = fromJson["id"].intValue
    }
    
    func getName()->String{
        return "Anonymous"
    }
    
    func toDictionary() -> [String:String] {
        return ["id":"\(self.id)"]
    }
    
    
}