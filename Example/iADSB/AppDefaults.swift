//
//  AppDefaults.swift
//  iADSB_Example
//
//  Created by Christopher Hobbs on 12/1/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import iADSB

class AppDefaults {
    
    enum Key: String {
         case allDevicesAlwaysOn, disabledDevices, disabledServices
    }
    
    var userDefaults:UserDefaults {
        return UserDefaults.standard
    }
    
    func object(forKey:Key) -> Any? {
        return userDefaults.object(forKey: forKey.rawValue)
    }
    
    func set(_ newValue:Any?, forKey:Key) {
        userDefaults.set(newValue, forKey: forKey.rawValue)
    }
    
    // defaults to true
    var allDevicesAlwaysOn:Bool {
        get {
            return object(forKey: .allDevicesAlwaysOn) as? Bool ?? true
        }
        set {
            set(newValue, forKey: .allDevicesAlwaysOn)
            initSettings()
        }
    }
    
    // disabled are stored so by default all are enabled
    var disabledDevicesStrings:[String] {
        get { return object(forKey: .disabledDevices) as? [String] ?? [] }
        set { set(newValue, forKey: .disabledDevices) }
    }
    
    // device like Stratux
    // uses the strings stored in defaults and returns enums
    var disabledDevices:[IADSB.Device.Identifier] {
        return disabledDevicesStrings.map { (string) -> IADSB.Device.Identifier? in
            IADSB.Device.Identifier(rawValue: string)
            }.compactMap { $0 }
    }
    
    var enabledDevices:[IADSB.Device.Identifier] {
        let disabled = disabledDevices
        return IADSB.Device.Identifier.allCases.filter { !disabled.contains($0) }
    }
    
    func enableDevice(name:String?, enabled:Bool) {
        disable(key:.disabledDevices, name:name, disabled:!enabled)
        print("Enabled Devices: \(enabledDevices)")
    }
    
    // a Service corresponds to a type like GPS that will be displayed
    // disabled are stored so by default all are enabled
    var disabledServiceStrings:[String] {
        get { return object(forKey: .disabledServices) as? [String] ?? [] }
        set { set(newValue, forKey: .disabledServices) }
    }
    
    // uses the strings stored in defaults and returns enums
    var disabledServices:[IADSB.Service.Category] {
        return disabledServiceStrings.map { (string) -> IADSB.Service.Category? in
            IADSB.Service.Category(rawValue: string)
            }.compactMap { $0 }
    }
    
    var enabledServices:[IADSB.Service.Category] {
        let disabled = disabledServices
        return IADSB.Service.Category.allCases.filter { !disabled.contains($0) }
    }
    
    func enableService(name:String?, enabled:Bool) {
        disable(key:.disabledServices, name:name, disabled:!enabled)
        print("Enabled Services: \(enabledServices)")
    }
    
    // if disabled is true then adds name to the array identified by key
    // if disabled is false then removes name from the array identified by key
    private func disable(key:Key, name:String?, disabled:Bool) {
        guard let name = name else { return }
        if disabled {
            addToStrings(key: key, value: name)
        } else {
            removeFromStrings(key: key, value: name)
        }
    }
    
    // adds value to array identified by key if it's not already there
    private func addToStrings(key:Key, value:String) {
        var strings = object(forKey: key) as? [String] ?? []
        if !strings.contains(value) {
            strings.append(value)
            set(strings, forKey: key)
        }
    }
    
    // removes value from array identified by key
    private func removeFromStrings(key:Key, value:String) {
        var strings = object(forKey: key) as? [String] ?? []
        strings = strings.filter { $0 != value }
        set(strings, forKey: key)
    }
    
    func initSettings() {
        AppDelegate.instance.manager.setAll(alwaysOn: allDevicesAlwaysOn)
    }
}
