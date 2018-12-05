//
//  Provider.swift
//  iadsb
//
//  Created by Christopher Hobbs on 10/11/18.
//

import Foundation

public extension IADSB {
    public class Provider:Hashable {
        
        public var gps:IADSB.GPS? = nil
        public var ahrs:IADSB.AHRS? = nil
        public var barometer:IADSB.Barometer? = nil
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
        
        public static func == (lhs: IADSB.Provider, rhs: IADSB.Provider) -> Bool {
            return lhs.name == rhs.name
        }
        
        public var hashValue:Int {
            return name.hashValue
        }
    }
}
