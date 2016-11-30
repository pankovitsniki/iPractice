//
//  TaskListTableViewController.swift
//  iPractice
//
//  Created by Nikolett Pankovits on 10/19/16.
//  Copyright © 2016 Nikolett Pankovits. All rights reserved.
//

import UIKit


class TaskListTableViewController: UITableViewController {
    
    @IBAction func editButtonPressed(_ sender: AnyObject) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTasks.shared.list.count
    }
    
    override func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        cell.textLabel?.text = AllTasks.shared.list[indexPath.row].name
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            AllTasks.shared.list.remove(at: indexPath.row)
            tableView.reloadData()
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
                if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                    pvc.task = AllTasks.shared.list[indexPath.row]
                }
            }
        }
    }
}
