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
    
    func addTask(_ name: String) {
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
        }
    }
    
    public func saveData() {
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0] as NSString
        let dataFilePath = docsDir.appendingPathComponent("data.archive")
        
        NSKeyedArchiver.archiveRootObject(list, toFile: dataFilePath)
        
    }
}
