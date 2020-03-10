//
//  Item.swift
//  ToDoApp
//
//  Created by TechFun on 10/03/2020.
//  Copyright © 2020 TechFunMyanmar. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Item{
    
    var ref : DatabaseReference!
   
    var title : String?
    var description : String?
    init(snapshot : DataSnapshot){
        ref = snapshot.ref
        let data = snapshot.value as! Dictionary<String , String>
        title = data["title"]! as String
        //description = data["description"]! as String
    }
}
