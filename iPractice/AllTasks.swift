//
//  AllTasks.swift
//  iPractice
//
//  Created by Nikolett Pankovits on 10/25/16.
//  Copyright © 2016 Nikolett Pankovits. All rights reserved.
//

import Foundation

var tasks = AllTasks()

struct Task {
    var name: String
}

class AllTasks {
    
    var list = [Task]()
    
    func addTask(name: String) {
        list.append(Task(name: name))
    }
    
}
