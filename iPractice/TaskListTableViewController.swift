//
//  TaskListTableViewController.swift
//  iPractice
//
//  Created by Nikolett Pankovits on 10/19/16.
//  Copyright © 2016 Nikolett Pankovits. All rights reserved.
//

import UIKit


class TaskListTableViewController: UITableViewController {
    
    @IBOutlet var taskListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskListTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        taskListTable.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.list.count
    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        cell.textLabel!.text = tasks.list[indexPath.row].name
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            tasks.list.remove(at: indexPath.row)
            taskListTable.reloadData()
        }
    }
    
}
