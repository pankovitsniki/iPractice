//
//  MainTaskListTableViewController.swift
//  iPractice
//
//  Created by Nikolett Pankovits on 10/20/16.
//  Copyright © 2016 Nikolett Pankovits. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskNameTextField: UITextField!
    
    // MARK : Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        //Task field is empty, don't add anything
        if (taskNameTextField.text == ""){
            // TODO: SVProgressHud
            print("You haven't added any tasks. Please try again!")
        } else {
            //add task
            let name: String = taskNameTextField.text!
            AllTasks.shared.addTask(name: name)
            
            //dismiss keyboard and reset fields
            dismiss(animated: true, completion: nil)
        
        }
        
    }

}
