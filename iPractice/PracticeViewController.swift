//
//  PracticeViewController.swift
//  iPractice
//
//  Created by Nikolett Pankovits on 10/25/16.
//  Copyright © 2016 Nikolett Pankovits. All rights reserved.
//

import UIKit


class PracticeViewController: UIViewController {
    
    @IBOutlet weak var timerButton: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var task: Task?
    fileprivate var counter = 1200
    fileprivate var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerButton.text = timeFormatted(counter)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = task?.name
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func setLabelText() {
        timerButton.text = timeFormatted(counter)
    }
    
    func updateCounter() {
        counter -= 1
        if counter < 0 {
            timer.invalidate()
            task?.completionDates.append(Date())
        } else {
            setLabelText()
        }
    }
    
    // MARK: - Actions
    @IBAction func startButtonPressed(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        counter = 1200
        setLabelText()
        
    }

}
