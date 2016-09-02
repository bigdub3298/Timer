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

        setAlarmButton.backgroundColor = UIColor.blueColorTimer()
        setAlarmButton.tintColor = UIColor.lightBlueColorTimer()
        datePickerView.minimumDate = NSDate()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AlarmViewController.alarmComplete), name: Alarm.notifComplete, object: nil)
        
        guard let localNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else { return }
        alarm.cancel()
        
        for notification in localNotifications {
            if notification.category == Alarm.categoryAlarm {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                
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
    
    func switchToAlarmNotSet() {
        setAlarmButton.setTitle("Set Alarm", forState: .Normal)
        alarmSetLabel.text = "Your alarm is not set."
        alarmDateLabel.text = ""
        
        datePickerView.minimumDate = NSDate()
        datePickerView.date = NSDate()
        datePickerView.userInteractionEnabled = true
        
    }
}
