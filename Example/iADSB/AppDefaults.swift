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
    var userDefaults:UserDefaults {
        return UserDefaults.standard
    }
    
    // defaults to true
    var allProvidersAlwaysOn:Bool {
        get {
            return userDefaults.object(forKey: "allProvidersAlwaysOn") as? Bool ?? true
        }
        set {
            userDefaults.set(newValue, forKey: "allProvidersAlwaysOn")
            initSettings()
        }
    }
    
    // disabled are stored so by default all are enabled
    var disabledProviderStrings:[String] {
        get { return userDefaults.object(forKey: "disabledProviders") as? [String] ?? [] }
        set { userDefaults.set(newValue, forKey: "disabledProviders") }
    }
    
    // a Provider is a device like Stratux
    // uses the strings stored in defaults and returns enums
    var disabledProviders:[IADSB.Provider.Implementation] {
        guard let strings = userDefaults.object(forKey: "disabledProviders") as? [String] else { return [] }
        return strings.map { (string) -> IADSB.Provider.Implementation? in
            IADSB.Provider.Implementation(rawValue: string)
            }.compactMap { $0 }
    }
    
    var enabledProviders:[IADSB.Provider.Implementation] {
        let disabled = disabledProviders
        return IADSB.Provider.Implementation.allCases.filter { !disabled.contains($0) }
    }
    
    func enableProvider(name:String?, enabled:Bool) {
        disable(key:"disabledProviders", name:name, disabled:!enabled)
        print("Enabled Providers: \(enabledProviders)")
    }
    
    // a Service corresponds to a model type that will be displayed
    // disabled are stored so by default all are enabled
    var disabledServiceStrings:[String] {
        get { return userDefaults.object(forKey: "disabledServices") as? [String] ?? [] }
        set { userDefaults.set(newValue, forKey: "disabledServices") }
    }
    
    // uses the strings stored in defaults and returns enums
    var disabledServices:[IADSB.Model.Service] {
        guard let strings = userDefaults.object(forKey: "disabledServices") as? [String] else { return [] }
        return strings.map { (string) -> IADSB.Model.Service? in
            IADSB.Model.Service(rawValue: string)
            }.compactMap { $0 }
    }
    
    var enabledServices:[IADSB.Model.Service] {
        let disabled = disabledServices
        return IADSB.Model.Service.allCases.filter { !disabled.contains($0) }
    }
    
    func enableService(name:String?, enabled:Bool) {
        disable(key:"disabledServices", name:name, disabled:!enabled)
        print("Enabled Services: \(enabledServices)")
    }
    
    // if disabled is true then adds name to the array identified by key
    // if disabled is false then removes name from the array identified by key
    private func disable(key:String, name:String?, disabled:Bool) {
        guard let name = name else { return }
        if disabled {
            addToStrings(key: key, value: name)
        } else {
            removeFromStrings(key: key, value: name)
        }
    }
    
    // adds value to array identified by key if it's not already there
    private func addToStrings(key:String, value:String) {
        var strings = userDefaults.object(forKey: key) as? [String] ?? []
        if !strings.contains(value) {
            strings.append(value)
            userDefaults.set(strings, forKey: key)
        }
    }
    
    // removes value from array identified by key
    private func removeFromStrings(key:String, value:String) {
        var strings = userDefaults.object(forKey: key) as? [String] ?? []
        strings = strings.filter { $0 != value }
        userDefaults.set(strings, forKey: key)
    }
    
    func initSettings() {
        AppDelegate.instance.manager.setAll(alwaysOn: allProvidersAlwaysOn)
    }
}
