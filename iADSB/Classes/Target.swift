//
//  Target.swift
//  iADSB
//
//  Created by Christopher Hobbs on 2/6/19.
//

import Foundation
import CoreLocation

public class Target: ServiceJson & Codable {
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
    
    public var altitudeFeet:Double? {
        guard let altitude = altitude else { return nil }
        return Constants.feet(meters:altitude);
    }
    
    public var location:CLLocation? {
        return GPS.location(latitude:latitude, longitude:longitude, horizontalAccuracy:positionValid ? 10.0 : nil, verticalAccuracy:positionValid ? 10.0 : nil, altitude:altitude, courseTrue:bearingTrue, speed:speed , timestamp:timestamp)
    }
    
    public func distance(fromLocation:CLLocation?) -> Double? {
        guard let location = location, let from = fromLocation else {
            return nil
        }
        return location.distance(from: from)
    }
    
    public func distanceNM(fromLocation:CLLocation?) -> Double? {
        return Constants.nm(meters: distance(fromLocation: fromLocation))
    }
    
    public var speedKnots:Double? {
        return Constants.knots(metersPerSecond: speed)
    }
    
    public func headingTrue(fromLocation:CLLocation?) -> Double? {
        return Constants.headingTrue(from: fromLocation, to: self.location)
    }
    
    public func headingMagnetic(fromLocation:CLLocation?) -> Double? {
        return Constants.headingMagnetic(from: fromLocation, to: self.location)
    }
    
    public override func afterDecode() {
        super.afterDecode()
        if !positionValid {
            latitude = nil
            longitude = nil
        }
        if !speedValid {
            speed = nil
            verticalSpeed = nil
        }
        if !bearingValid {
            bearingTrue = nil
        }
    }
}

