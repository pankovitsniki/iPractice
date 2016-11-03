//
//  PracticeViewController.swift
//  iPractice
//
//  Created by Nikolett Pankovits on 10/25/16.
//  Copyright © 2016 Nikolett Pankovits. All rights reserved.
//

import UIKit


class PracticeViewController: UIViewController,UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var timerButton: UILabel!

    @IBOutlet weak var startButton: UIButton!
    
    var counter = 1200
    var timer = Timer()
    
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
    
    func setLabelText(value: String) {
        timerButton.text = value
    }
    
    func updateCounter() {
        counter -= 1
        if counter < 0 {
            timer.invalidate()
        }
        else {
            setLabelText(value: timeFormatted(totalSeconds: counter))
        }
    }
    
    func updateLabel(value: Int) {
        setLabelText(value: timeFormatted(totalSeconds: value))
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
        timerButton.text = timeFormatted(totalSeconds: counter)
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

}
