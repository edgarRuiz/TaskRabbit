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
//        task = "";
//        completed = false;
//        print("init method")
    }

    
    required init?(coder aDecoder: NSCoder) {
        
        let decodedTask = aDecoder.decodeObject(forKey: "task") as? String ?? "";
        let decodedCompleted = aDecoder.decodeBool(forKey: "completed");
        self.task = decodedTask;
        self.completed = decodedCompleted;
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.task, forKey: "task")
        aCoder.encode(self.completed, forKey: "completed")

    }
}
