//
//  Milestone.swift
//  BabyMilestones
//
//  Created by Luke Cheskin on 11/11/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Milestone {
    
    var title: String!
    var content: String!
    var uid: String!
    var red: CGFloat!
    var blue: CGFloat!
    var green: CGFloat!
    var ref: FIRDatabaseReference?
    var key: String!
    
    init(title: String, content: String, uid: String, red: CGFloat, blue: CGFloat, green: CGFloat, key: String = "") {
        
        self.title = title
        self.content = content
        self.uid = uid
        self.red = red
        self.blue = blue
        self.green = green
        self.key = key
        self.ref = FIRDatabase.database().reference()
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        self.title = (snapshot.value as? NSDictionary)?["title"] as? String
        self.content = (snapshot.value as? NSDictionary)?["content"] as? String
        self.uid = (snapshot.value as? NSDictionary)?["uid"] as? String
        self.red = (snapshot.value as? NSDictionary)?["red"] as? CGFloat
        self.blue = (snapshot.value as? NSDictionary)?["blue"] as? CGFloat
        self.green = (snapshot.value as? NSDictionary)?["green"] as? CGFloat
        self.key = snapshot.key
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: AnyObject] {
        
        return ["title": title as AnyObject, "content": content as AnyObject,"uid": uid as AnyObject, "blue": blue as AnyObject,"red": red as AnyObject,"green": green as AnyObject]
    }
    
}
