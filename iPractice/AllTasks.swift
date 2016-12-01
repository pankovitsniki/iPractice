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
            let complDateTest1 = "01-10-2016"
            let complDateTest2 = "02-10-2016"
            let complDateTest3 = "03-10-2016"
            let complDateTest4 = "04-10-2016"
            let complDateTest5 = "05-10-2016"
            let complDateTest6 = "06-10-2016"
            let complDateTest7 = "07-10-2016"
            let complDateTest8 = "08-10-2016"
            let complDateTest9 = "09-10-2016"
            let complDateTest10 = "10-10-2016"
            let complDateTest11 = "11-10-2016"

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let date1 = dateFormatter.date(from: complDateTest1)
            let date2 = dateFormatter.date(from: complDateTest2)
            let date3 = dateFormatter.date(from: complDateTest3)
            let date4 = dateFormatter.date(from: complDateTest4)
            let date5 = dateFormatter.date(from: complDateTest5)
            let date6 = dateFormatter.date(from: complDateTest6)
            let date7 = dateFormatter.date(from: complDateTest7)
            let date8 = dateFormatter.date(from: complDateTest8)
            let date9 = dateFormatter.date(from: complDateTest9)
            let date10 = dateFormatter.date(from: complDateTest10)
            let date11 = dateFormatter.date(from: complDateTest11)
            let taskTest1 = Task.init(name: "Sample Test 1")
            let taskTest2 = Task.init(name: "Sample Test 2")
            let taskTest3 = Task.init(name: "Sample Test 3")
            taskTest1.completionDates.append(date1!)
            taskTest1.completionDates.append(date2!)
            taskTest1.completionDates.append(date3!)
            taskTest1.completionDates.append(date7!)
            taskTest1.completionDates.append(date8!)
            taskTest1.completionDates.append(date9!)
            taskTest1.completionDates.append(date4!)
            taskTest1.completionDates.append(date5!)
            taskTest1.completionDates.append(date6!)
            taskTest1.completionDates.append(date10!)
            taskTest1.completionDates.append(date11!)
            taskTest1.completionDates.append(date1!)
            taskTest2.completionDates.append(date3!)
            taskTest2.completionDates.append(date4!)
            taskTest2.completionDates.append(date8!)
            taskTest2.completionDates.append(date10!)
            taskTest2.completionDates.append(date11!)
            taskTest2.completionDates.append(date11!)
            taskTest2.completionDates.append(date6!)
            taskTest2.completionDates.append(date11!)
            taskTest2.completionDates.append(date4!)
            taskTest2.completionDates.append(date5!)
            taskTest3.completionDates.append(date1!)
            taskTest3.completionDates.append(date1!)
            taskTest3.completionDates.append(date2!)
            taskTest3.completionDates.append(date3!)
            taskTest3.completionDates.append(date7!)
            taskTest3.completionDates.append(date8!)
            taskTest3.completionDates.append(date9!)
            taskTest3.completionDates.append(date10!)
            taskTest3.completionDates.append(date11!)
            taskTest3.completionDates.append(date6!)
            taskTest3.completionDates.append(date11!)
            taskTest3.completionDates.append(date4!)
            taskTest3.completionDates.append(date5!)
            taskTest2.completionDates.append(date1!)
            taskTest2.completionDates.append(date1!)
            taskTest2.completionDates.append(date2!)
            taskTest2.completionDates.append(date3!)
            taskTest2.completionDates.append(date7!)
            taskTest2.completionDates.append(date8!)
            taskTest2.completionDates.append(date9!)
            taskTest2.completionDates.append(date10!)
            taskTest2.completionDates.append(date11!)
            taskTest2.completionDates.append(date6!)
            taskTest2.completionDates.append(date10!)
            taskTest2.completionDates.append(date6!)
            taskTest2.completionDates.append(date6!)

            list.append(taskTest1)
            list.append(taskTest2)
            list.append(taskTest3)
            
        }
    }
    
    public func saveData() {
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0] as NSString
        let dataFilePath = docsDir.appendingPathComponent("data.archive")
        
        NSKeyedArchiver.archiveRootObject(list, toFile: dataFilePath)
    }
}
