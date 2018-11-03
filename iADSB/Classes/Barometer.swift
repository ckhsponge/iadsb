//
//  Barometer.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/16/18.
//

import Foundation
public extension IADSB {
    public class Barometer: Model,Codable {
        public var temperature:Double? = nil
        public var pressureAltitude:Double? = nil
        public var verticalSpeed:Double? = nil
        public var timestamp:Date? = nil
        
        public var temperatureFarenheit:Double? {
            guard let temperature = temperature else { return nil }
            return IADSB.Constants.farenheit(celsius: temperature)
        }
        
        public var verticalSpeedFPM:Double? {
            guard let verticalSpeed = verticalSpeed else { return nil }
            return IADSB.Constants.feetPerMinute(metersPerSecond: verticalSpeed);
        }
        
        public var pressureAltitudeFeet:Double? {
            guard let pressureAltitude = pressureAltitude else { return nil }
            return IADSB.Constants.feet(meters: pressureAltitude);
        }
        
        public var description:String {
            return "temperature: \(String(describing: temperature)), altitude: \(String(describing: pressureAltitude)), vspeed: \(String(describing: verticalSpeed)) timestamp: \(String(describing: timestamp))"
        }
    }
}
