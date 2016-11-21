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
    @IBAction func editButtonPressed(_ sender: AnyObject) {
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    let name = "name"
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        taskListTable.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AllTasks.shared.list.count
    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        cell.textLabel!.text = AllTasks.shared.list[indexPath.row].name
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            AllTasks.shared.list.remove(at: indexPath.row)
            taskListTable.reloadData()
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        if fromIndexPath.row > to.row {
            AllTasks.shared.list.insert(AllTasks.shared.list[fromIndexPath.row], at: to.row)
            AllTasks.shared.list.remove(at: fromIndexPath.row + 1)
        } else {
            AllTasks.shared.list.insert(AllTasks.shared.list[fromIndexPath.row], at: to.row + 1)
            AllTasks.shared.list.remove(at: fromIndexPath.row)
        }
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startPractice" {
            // we should prepare our PracticeViewController
            if let pvc = segue.destination as? PracticeViewController {
                if let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell) {
                    pvc.task = AllTasks.shared.list[indexPath.row]
                }
            }
            
        }
    }
    
    
}
