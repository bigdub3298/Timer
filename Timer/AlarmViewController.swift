//
//  AlarmViewController.swift
//  Timer
//
//  Created by Wesley Austin on 8/29/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var alarmSetLabel: UILabel!
    @IBOutlet weak var alarmDateLabel: UILabel!
    @IBOutlet weak var setAlarmButton: UIButton!
    
    
    var alarm = Alarm()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Sets alarm button appearance
        setAlarmButton.backgroundColor = UIColor.blueColorTimer()
        setAlarmButton.tintColor = UIColor.lightBlueColorTimer()
        
        // Ensures that users cannot pick a later date than the current date
        datePickerView.minimumDate = NSDate()
        
        // Makes the AlarmViewController an observer of the alarm complete notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AlarmViewController.alarmComplete), name: Alarm.notifComplete, object: nil)
        
        // Grabs all local notifications
        guard let localNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else { return }
        
        // Cancels previous alarm objects
        alarm.cancel()
        
        // Loops through all local notifications
        for notification in localNotifications {
            if notification.category == Alarm.categoryAlarm {
                // Cancels the alarm local notification
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                
                // Arms a new alarm with the previous fire date
                guard let fireDate = notification.fireDate else { return }
                alarm.arm(fireDate)
                switchToAlarmSet()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func setAlarmButtonTapped(sender: UIButton) {
        if !alarm.isArmed {
            alarm.arm(datePickerView.date)
            switchToAlarmSet()
        } else {
            alarm.cancel()
            switchToAlarmNotSet()
        }
    }
    
    func alarmComplete() {
        switchToAlarmNotSet()
    }

    /// Switches to the alarm set view
    func switchToAlarmSet() {
        setAlarmButton.setTitle("Cancel Alarm", forState: .Normal)
        alarmSetLabel.text = "Your alarm is set!"
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        dateFormatter.dateStyle = .LongStyle
        
        if let date = alarm.alarmDate {
            alarmDateLabel.text = dateFormatter.stringFromDate(date)
            datePickerView.date = date
        } else {
            alarmDateLabel.text = ""
        }
        
        datePickerView.userInteractionEnabled = false
    }
    
    /// Switches to the alarm not set view
    func switchToAlarmNotSet() {
        setAlarmButton.setTitle("Set Alarm", forState: .Normal)
        alarmSetLabel.text = "Your alarm is not set."
        alarmDateLabel.text = ""
        
        datePickerView.minimumDate = NSDate()
        datePickerView.date = NSDate()
        datePickerView.userInteractionEnabled = true
        
    }
}
