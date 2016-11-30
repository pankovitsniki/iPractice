//
//  PracticeViewController.swift
//  iPractice
//
//  Created by Nikolett Pankovits on 10/25/16.
//  Copyright © 2016 Nikolett Pankovits. All rights reserved.
//

import UIKit
import AVFoundation


class PracticeViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel! {
        didSet {
            timerLabel.textColor = UIColor.foreground
        }
    }
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var task: Task?
    private var counter = 3 // 1200
    private var timer = Timer()
    let systemSoundID: SystemSoundID = 1325
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = timeFormatted(totalSeconds: counter)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = task?.name
        startButton.tintColor = UIColor.tint
    }
    
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func setLabelText() {
        timerLabel.text = timeFormatted(totalSeconds: counter)
    }
    
    func updateCounter() {
        counter -= 1
        if counter < 0 {
            timer.invalidate()
            AudioServicesPlaySystemSound (systemSoundID)
            timerLabel.text = "COMPLETED"
            timerLabel.textColor = UIColor.green
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
