//
//  Task.swift
//  TaskRabbit
//
//  Created by Edgar Ruiz on 6/4/18.
//  Copyright © 2018 Edgar Ruiz. All rights reserved.
//

import Foundation

class Task : NSObject, NSCoding {
    
    var task : String = "";
    var completed : Bool = false;
    
    override init(){
        task = "";
        completed = false;
    }

    
    required init?(coder aDecoder: NSCoder) {
        
        let task = aDecoder.decodeObject(forKey: "task") as? String ?? "";
        let completed = aDecoder.decodeBool(forKey: "completed");
        self.task = task;
        self.completed = completed;
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(task, forKey: "task")
        aCoder.encode(completed, forKey: "completed")
    }
}
