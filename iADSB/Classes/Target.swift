//
//  Target.swift
//  iADSB
//
//  Created by Christopher Hobbs on 2/6/19.
//

import Foundation


public extension IADSB {
    public class Target: IADSB.ServiceJson & Codable {
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
        public var icaoAddress:Int? = nil
        public var registraion:String? = nil
        public var tailNumber:String? = nil
        public var squawk:Int? = nil
        public var altitudeAt:Date? = nil
        public var positionAt:Date? = nil
        public var speedAt:Date? = nil
        public var timestamp:Date? = nil
    
        // constructs an instance from json data, MUST be defined in this class because Codable is on this class
        override public class func decoderClass(_ decoder:JSONDecoder, data:Data) throws -> ServiceCodable? {
            return try decoder.decode(self, from: data)
        }
    }
}
