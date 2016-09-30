//
//  Alarm.swift
//  Timer
//
//  Created by Wesley Austin on 8/29/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class Alarm: NSObject {
    // read only property
    private(set) var alarmDate: NSDate?
    
    static let categoryAlarm = "categoryAlarm"
    static let notifComplete = "notifComplete"
    
    // computes weather the alarm is active or nil
    var isArmed: Bool {
        get {
            if alarmDate != nil {
                return true
            } else {
                return false
            }
        }
    }
    
    private var localNotification: UILocalNotification?
    
    /// Actives the alarm and shedules a local notification with the passed in fire date
    func arm(fireDate: NSDate) {
        alarmDate = fireDate
        let alarmNotif = UILocalNotification()
        alarmNotif.fireDate = alarmDate
        alarmNotif.timeZone = NSTimeZone.localTimeZone()
        alarmNotif.alertBody = "Alarm complete"
        alarmNotif.alertTitle = "Alarm"
        alarmNotif.category = Alarm.categoryAlarm

        UIApplication.sharedApplication().scheduleLocalNotification(alarmNotif)
        localNotification = alarmNotif
    }
    
    /// cancels the alarm
    func cancel() {
        if isArmed {
            alarmDate = nil
            if let localNotification = localNotification {
                UIApplication.sharedApplication().cancelLocalNotification(localNotification)
            }
        }
    }
    
    /// Posts a notification for when the alarm is complete 
    static func alarmComplete() {
        NSNotificationCenter.defaultCenter().postNotificationName(Alarm.notifComplete, object: nil, userInfo: nil)
    }
}
