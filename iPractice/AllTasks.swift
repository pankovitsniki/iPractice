//
//  AllTasks.swift
//  iPractice
//
//  Created by Nikolett Pankovits on 10/25/16.
//  Copyright © 2016 Nikolett Pankovits. All rights reserved.
//

import Foundation

var tasks: AllTasks = AllTasks()

struct task {
    var name: String
}

class AllTasks: NSObject {
    var taskList = [task]()
    
    func addTask(name: String) {
        taskList.append(task(name: name))
    }    
}
