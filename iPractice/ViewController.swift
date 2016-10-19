//
//  ViewController.swift
//  iPractice
//
//  Created by Nikolett Pankovits on 8/20/16.
//  Copyright © 2016 Nikolett Pankovits. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var toDoButton: UIButton!
    @IBOutlet weak var toDoList: UIPickerView!
    @IBOutlet weak var showTimer: UILabel!
    
    let list = ["Piano", "Programming", "Vocalizing", "Exercising", "Reading"]
    
    var counter = 15
    
    var timer : Timer!
    
    
    @IBOutlet weak var smileIfYouFinished: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        toDoList.dataSource = self
        toDoList.delegate = self
        showTimer.text = String(counter)        
    }
    
    internal func updateTimer() {
        counter = counter - 1
        if(counter > 0) {
            showTimer.text = String(counter)
        } else {
            counter = 15
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func toDoButtonPressed(_ sender: AnyObject) {
        toDoList.isHidden = false
    }
    
    @IBAction func startButtonPressed(_ sender: AnyObject) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        timer.invalidate()
        timer = nil
        showTimer.text = "1"   
        smileIfYouFinished.isHidden = false
//        smileIfYouFinished.image = UIImage(named: "happy.png")
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        toDoButton.setTitle(list[row], for: UIControlState()) // UIControlState.normal
        toDoList.isHidden = true
    }
}

