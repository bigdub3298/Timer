//
//  TimerViewController.swift
//  Timer
//
//  Created by Wesley Austin on 8/28/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit
class TimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak var hoursPickerView: UIPickerView!
    @IBOutlet weak var minutesPickerView: UIPickerView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var pickerStackView: UIStackView!
    
    
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hoursPickerView.delegate = self
        minutesPickerView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TimerViewController.updateTimerLabel), name: Timer.kSecondTick, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TimerViewController.timerComplete), name:Timer.kTimerComplete, object: nil)
        
        minutesPickerView.selectRow(1, inComponent: 0, animated: true)
        
        view.layoutIfNeeded()
        
        pauseButton.layer.cornerRadius = pauseButton.bounds.height / 2
        pauseButton.layer.masksToBounds = true
        pauseButton.layer.borderWidth = 1.0
        pauseButton.layer.borderColor = pauseButton.currentTitleColor.CGColor
        
        startButton.layer.cornerRadius = startButton.bounds.height / 2
        startButton.layer.masksToBounds = true
        startButton.layer.borderWidth = 1.0
        startButton.layer.borderColor = startButton.currentTitleColor.CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PickerView Protocols
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if hoursPickerView === pickerView {
            return 24
        } else if minutesPickerView === pickerView {
            return 60
        } else {
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return String(row)
    }
    
    
    
    @IBAction func pauseButtonTapped(sender: UIButton) {
        // add code to pause timer  
    }
    
    @IBAction func startButtonTapped(sender: UIButton) {
        toggleTimer()
    }
    
    
    // MARK: - View updating methods
    func toggleTimer() {
        if timer.isOn {
            timer.stopTimer()
            switchToPickerView()
        } else {
            switchToTimerView()
            
            let hours = hoursPickerView.selectedRowInComponent(0)
            let minutes = minutesPickerView.selectedRowInComponent(0) + (hours * 60)
            let totalSecondsOnTimer = NSTimeInterval(minutes * 60)
            
            timer.setTimer(totalSecondsOnTimer, totalSeconds: totalSecondsOnTimer)
            updateTimerLabel()
            timer.startTimer(totalSecondsOnTimer)
            
        }
    }

    
    func timerComplete() {
        switchToPickerView()
    }
    func updateTimerLabel() {
        timerLabel.text = timer.string
    }
    
    func switchToTimerView() {
        timerLabel.hidden = false
        pickerStackView.hidden = true
        startButton.setTitle("Cancel", forState: .Normal)
    }
    
    func switchToPickerView() {
        pickerStackView.hidden = false
        timerLabel.hidden = true
        startButton.setTitle("Start", forState: .Normal)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
