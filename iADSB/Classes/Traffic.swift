//
//  Traffic.swift
//  iADSB
//
//  Created by Christopher Hobbs on 1/2/19.
//

import Foundation

public extension IADSB {
    public class Traffic: IADSB.Model {
        public class Target: IADSB.Model,Codable {
            public var latitude:Double? = nil
            public var longitude:Double? = nil
            public var altitude:Double? = nil
            public var speed:Double? = nil
            public var verticalSpeed:Double? = nil
            public var bearingTrue:Double? = nil
            public var trackTrue:Double? = nil
            public var positionValid:Bool = true
            public var bearingValid:Bool = true
            public var speedValid:Bool = true
            public var onGround:Bool = false
            public var icaoAddress:String? = nil
            public var registraion:String? = nil
            public var tailNumber:String? = nil
            public var squawk:Int? = nil
            public var altitudeAt:Date? = nil
            public var positionAt:Date? = nil
            public var speedAt:Date? = nil
            public var timestamp:Date? = nil
        }
        
        var targetsMap = [String:Target]()
    }
}
