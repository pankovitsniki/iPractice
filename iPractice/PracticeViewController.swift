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
    @IBOutlet weak var resetButton: UIButton!
    var task: Task?
    private var counter = 10 // 1200
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerButton.text = timeFormatted(totalSeconds: counter)
        
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
    
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func setLabelText() {
        timerButton.text = timeFormatted(totalSeconds: counter)
    }
    
    func updateCounter() {
        counter -= 1
        if counter < 0 {
            timer.invalidate()
            startButton.setTitle("COMPLETED", for: .normal)
            startButton.isEnabled = false
            resetButton.isEnabled = false
            task?.completionDates.append(Date())
        } else {
            setLabelText()
        }
    }
    
    // MARK: - Actions
    @IBAction func startButtonPressed(_ sender: Any) {
        if startButton.currentTitle == "START"  {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            startButton.setTitle("PAUSE", for: .normal)
        } else {
            startButton.setTitle("START", for: .normal)
            timer.invalidate()
        }
        
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        counter = 1200
        setLabelText()
    }

}
