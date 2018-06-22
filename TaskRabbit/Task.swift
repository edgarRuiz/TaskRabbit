//
//  Task.swift
//  TaskRabbit
//
//  Created by Edgar Ruiz on 6/16/18.
//  Copyright © 2018 Edgar Ruiz. All rights reserved.
//

import Foundation
import RealmSwift

class Task : Object{
    
    @objc dynamic var completed : Bool = false;
    @objc dynamic var task : String = ""
    var parentCategory = LinkingObjects(fromType: Category.self , property: "tasks")

}
