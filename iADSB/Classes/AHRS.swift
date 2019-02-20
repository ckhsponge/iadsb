//
//  AHRS.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/16/18.
//

import Foundation

public class AHRS: ServiceJson,Codable {
    public var pitch:Double? = nil
    public var roll:Double? = nil
    public var headingGyro:Double? = nil
    public var headingMagnetic:Double? = nil
    public var slipSkid:Double? = nil
    public var turnRate:Double? = nil
    public var gLoad:Double? = nil
    public var timestamp:Date? = nil
    
    // constructs an instance from json data, MUST be defined in this class because Codable is on this class
    override public class func decoderClass(_ decoder:JSONDecoder, data:Data) throws -> ServiceCodable? {
        return try decoder.decode(self, from: data)
    }
    
    public var description:String {
        return "pitch: \(String(describing: pitch)), roll: \(String(describing: roll)), headingGyro: \(String(describing: headingGyro)), "
        + "headingMagnetic: \(String(describing: headingMagnetic)), slipSkid: \(String(describing: slipSkid)), turnRate: \(String(describing: turnRate)), "
        + "gLoad: \(String(describing: gLoad))"
    }
}

