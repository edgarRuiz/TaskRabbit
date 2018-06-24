//
//  Category.swift
//  TaskRabbit
//
//  Created by Edgar Ruiz on 6/16/18.
//  Copyright © 2018 Edgar Ruiz. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = "";
    @objc dynamic var color : String = "";
    var tasks = List<Task>();
    
}
