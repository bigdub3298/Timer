//
//  AppearanceController.swift
//  Timer
//
//  Created by Wesley Austin on 8/29/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import Foundation
import UIKit

class AppearanceController {
    
    static func initializeAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.orangeColorTimer()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        UITabBar.appearance().barTintColor = UIColor.blueColorTimer()
        UITabBar.appearance().tintColor = UIColor.lightBlueColorTimer()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightBlueColorTimer()], forState: .Selected)
    }
}