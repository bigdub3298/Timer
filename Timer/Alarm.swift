//
//  Alarm.swift
//  Timer
//
//  Created by Wesley Austin on 8/29/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class Alarm: NSObject {
    private(set) var alarmDate: NSDate?
    static let categoryAlarm = "categoryAlarm"
    static let notifComplete = "notifComplete"
    
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
    
    func cancel() {
        if isArmed {
            alarmDate = nil
            if let localNotification = localNotification {
                UIApplication.sharedApplication().cancelLocalNotification(localNotification)
            }
        }
    }
    
    static func alarmComplete() {
        NSNotificationCenter.defaultCenter().postNotificationName(Alarm.notifComplete, object: nil, userInfo: nil)
    }
}
