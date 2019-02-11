//
//  Barometer.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/16/18.
//

import Foundation
public extension IADSB {
    public class Barometer: ServiceJson,Codable {
        public var temperature:Double? = nil
        public var pressureAltitude:Double? = nil
        public var verticalSpeed:Double? = nil
        public var timestamp:Date? = nil
        
        // constructs an instance from json data, MUST be defined in this class because Codable is on this class
        override public class func decoderClass(_ decoder:JSONDecoder, data:Data) throws -> ServiceCodable? {
            return try decoder.decode(self, from: data)
        }
        
        public var temperatureFarenheit:Double? {
            return IADSB.Constants.farenheit(celsius: temperature)
        }
        
        public var verticalSpeedFPM:Double? {
            return IADSB.Constants.feetPerMinute(metersPerSecond: verticalSpeed);
        }
        
        public var pressureAltitudeFeet:Double? {
            return IADSB.Constants.feet(meters: pressureAltitude);
        }
        
        public var description:String {
            return "temperature: \(String(describing: temperature)), altitude: \(String(describing: pressureAltitude)), vspeed: \(String(describing: verticalSpeed)) timestamp: \(String(describing: timestamp))"
        }
    }
}
