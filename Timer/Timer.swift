//
//  Timer.swift
//  Timer
//
//  Created by Wesley Austin on 8/28/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class Timer: NSObject {
    
    static let kSecondTick = "secondTick"
    static let kTimerComplete = "timerComplete"
    
    private(set) var seconds = NSTimeInterval(0)
    private(set) var totalSeconds = NSTimeInterval(0)
    private var timer: NSTimer?
    

    // Determines if the timer is on or not
    var isOn: Bool {
        if timer != nil {
            return true
        } else {
            return false
        }
    }
    
    // Saves the amount of seconds if the timer is paused
    var pausedSeconds: NSTimeInterval {
        let s = seconds
        return s
    }
    
    // Timer string representation 
    var string: String {
        get {
            let totalSeconds = Int(self.seconds)
            
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds - (hours * 3600)) / 60
            let seconds = totalSeconds - (hours * 3600) - (minutes * 60)
            
            var hoursString = ""
            if hours > 0 {
                hoursString = "\(hours):"
            }
            
            var minutesString = ""
            if minutes < 10 {
                minutesString = "0\(minutes):"
            } else {
                minutesString = "\(minutes):"
            }
            
            var secondsString = ""
            if seconds < 10 {
                secondsString = "0\(seconds)"
            } else {
                secondsString = "\(seconds)"
            }
            
            return hoursString + minutesString + secondsString
            
        }
    }
    
    /// Ticks the timer down by 1 second
    func secondTick() {
        
        seconds -= 1
        // Sends second tick notification
        NSNotificationCenter.defaultCenter().postNotificationName(Timer.kSecondTick, object: nil, userInfo: nil)
        if seconds <= 0 {
            stopTimer()
            // Sends timer complete notification
            NSNotificationCenter.defaultCenter().postNotificationName(Timer.kTimerComplete, object: nil, userInfo: nil)
        }
        
    }
    
    /// Set the timer with seconds and total seconds
    func setTimer(seconds: NSTimeInterval, totalSeconds: NSTimeInterval) {
        self.seconds = seconds
        self.totalSeconds = totalSeconds
    }
    
    /// Starts the timer if it is not on
    func startTimer(time: NSTimeInterval) {
        if !isOn {
            timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.1), target: self, selector: #selector(Timer.secondTick), userInfo: nil, repeats: true)
        }
    }
    
    /// Stops the timer if it is on and sets it nil
    func stopTimer() {
        if isOn {
            timer?.invalidate()
            timer = nil
        }
    }
    
    /// Restarts the timer with the previous total seconds 
    func restartTimer() {
        startTimer(totalSeconds)
        seconds = totalSeconds 
    }
}
