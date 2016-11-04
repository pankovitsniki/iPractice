//
//  AllTasks.swift
//  iPractice
//
//  Created by Nikolett Pankovits on 10/25/16.
//  Copyright © 2016 Nikolett Pankovits. All rights reserved.
//

import Foundation


struct Task {
    
    var name: String
    var completionDates = [Date]()
    init(name: String) {
        self.name = name
    }
        
}

class AllTasks: NSObject {
    
    static let shared: AllTasks = {
        let instance = AllTasks()
        return instance
    }()
    
    var list = [Task]()
    
    func addTask(name: String) {
        list.append(Task(name: name))
        
    }
    
}
