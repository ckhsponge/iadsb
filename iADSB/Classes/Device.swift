//
//  Device.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension IADSB {
    public class Device:Hashable {
        
        public enum Identifier: String, CaseIterable {
            case coreLocation, stratux, stratuxHttp
        }
        
        public var gps:IADSB.GPS? = nil
        public var ahrs:IADSB.AHRS? = nil
        public var barometer:IADSB.Barometer? = nil
        public var traffic:IADSB.Traffic? = nil
        
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
        
        public static func == (lhs: IADSB.Device, rhs: IADSB.Device) -> Bool {
            return lhs.name == rhs.name
        }
        
        public var hashValue:Int {
            return name.hashValue
        }
    }
}
