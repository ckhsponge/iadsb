//
//  AHRS.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/16/18.
//

import Foundation

public extension IADSB {
    public class AHRS: Model,Codable {
        var pitch:Double? = nil
        var roll:Double? = nil
        var headingGyro:Double? = nil
        var headingMagnetic:Double? = nil
        var slipSkid:Double? = nil
        var turnRate:Double? = nil
        var gLoad:Double? = nil
        
        public var description:String {
            return "pitch: \(String(describing: pitch)), roll: \(String(describing: roll)), headingGyro: \(String(describing: headingGyro)), "
            + "headingMagnetic: \(String(describing: headingMagnetic)), slipSkid: \(String(describing: slipSkid)), turnRate: \(String(describing: turnRate)), "
            + "gLoad: \(String(describing: gLoad))"
        }
    }
}
