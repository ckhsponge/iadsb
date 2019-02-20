//
//  Device.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public class Device:Hashable {
    
    public enum Identifier: String, CaseIterable {
        case coreLocation, stratux, stratuxHttp
    }
    
    public var gps:GPS? = nil
    public var ahrs:AHRS? = nil
    public var barometer:Barometer? = nil
    public var traffic:Traffic? = nil
    
    var manager:Manager
    var priority:Int
    var alwaysOn:Bool
    public var active:Bool = false
    
    public init(_ manager:Manager, priority:Int = 0, alwaysOn:Bool = false) {
        self.manager = manager
        self.priority = priority
        self.alwaysOn = alwaysOn
    }
    
    public func start() {
        active = true
    }
    
    public func stop() {
        active = false
    }
    
    public func checkOnce() {}
    
    public var name:String { return "UNDEFINED" }
    
    public static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.name == rhs.name
    }
    
    public var hashValue:Int {
        return name.hashValue
    }
}
