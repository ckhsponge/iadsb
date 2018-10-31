//
//  AHRS.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/16/18.
//

import Foundation

public extension IADSB {
    public class AHRS: Model,Codable {
        public var pitch:Double? = nil
        public var roll:Double? = nil
        public var headingGyro:Double? = nil
        public var headingMagnetic:Double? = nil
        public var slipSkid:Double? = nil
        public var turnRate:Double? = nil
        public var gLoad:Double? = nil
        public var timestamp:Date? = nil
        
        public var description:String {
            return "pitch: \(String(describing: pitch)), roll: \(String(describing: roll)), headingGyro: \(String(describing: headingGyro)), "
            + "headingMagnetic: \(String(describing: headingMagnetic)), slipSkid: \(String(describing: slipSkid)), turnRate: \(String(describing: turnRate)), "
            + "gLoad: \(String(describing: gLoad))"
        }
    }
}
