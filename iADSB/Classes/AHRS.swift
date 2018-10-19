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
    }
}
