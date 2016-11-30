//
//  AllTasks.swift
//  iPractice
//
//  Created by Nikolett Pankovits on 10/25/16.
//  Copyright © 2016 Nikolett Pankovits. All rights reserved.
//

import Foundation


class Task: NSObject, NSCoding {
    
    var name: String
    var completionDates = [Date]()
    init(name: String) {
        self.name = name
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let completionDates = aDecoder.decodeObject(forKey: "completionDates") as! [Date]
        
        self.init(name: name)
        self.completionDates.append(contentsOf: completionDates)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.completionDates, forKey: "completionDates")

    }
}

class AllTasks: NSObject {
    
    static let shared: AllTasks = {
        let instance = AllTasks()
        instance.loadData()
        return instance
    }()
    
    var list = [Task]()
    
    func addTask(name: String) {
        list.append(Task(name: name))
        
    }
    
    private func loadData() {
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0] as NSString
        let dataFilePath = docsDir.appendingPathComponent("data.archive")
        
        let filemgr = FileManager.default
        if filemgr.fileExists(atPath: dataFilePath) {
            let dataArray = NSKeyedUnarchiver.unarchiveObject(withFile: dataFilePath) as! [Task]
            list.append(contentsOf: dataArray)
        } else {
            // add fake data
            let complDateTest1 = "09-10-2016"
            let complDateTest2 = "02-10-2016"
            let complDateTest3 = "02-10-2016"
            let complDateTest4 = "04-10-2016"
            let complDateTest5 = "04-10-2016"
            let complDateTest6 = "05-10-2016"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let date1 = dateFormatter.date(from: complDateTest1)
            let date2 = dateFormatter.date(from: complDateTest2)
            let date3 = dateFormatter.date(from: complDateTest3)
            let date4 = dateFormatter.date(from: complDateTest4)
            let date5 = dateFormatter.date(from: complDateTest5)
            let date6 = dateFormatter.date(from: complDateTest6)
            let taskTest1 = Task.init(name: "Sample Test 1")
            let taskTest2 = Task.init(name: "Sample Test 2")
            taskTest1.completionDates.append(date1!)
            taskTest1.completionDates.append(date2!)
            taskTest1.completionDates.append(date3!)
            taskTest2.completionDates.append(date4!)
            taskTest2.completionDates.append(date5!)
            taskTest2.completionDates.append(date6!)
            list.append(taskTest1)
            list.append(taskTest2)
        }
    }
    
    public func saveData() {
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0] as NSString
        let dataFilePath = docsDir.appendingPathComponent("data.archive")
        
        NSKeyedArchiver.archiveRootObject(list, toFile: dataFilePath)
    }
}
