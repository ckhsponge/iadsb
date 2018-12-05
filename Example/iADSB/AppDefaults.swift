//
//  AppDefaults.swift
//  iADSB_Example
//
//  Created by Christopher Hobbs on 12/1/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

class AppDefaults {
    var userDefaults:UserDefaults {
        return UserDefaults.standard
    }
    
    // defaults to true
    var allProvidersAlwaysOn:Bool {
        get {
            if let b = userDefaults.object(forKey: "allProvidersAlwaysOn") as? Bool {
                return b
            } else {
                return true
            }
        }
        set {
            userDefaults.set(newValue, forKey: "allProvidersAlwaysOn")
            initSettings()
        }
    }
    
    func initSettings() {
        AppDelegate.instance.manager.setAll(alwaysOn: allProvidersAlwaysOn)
    }
}
