//
//  Barometer.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/16/18.
//

import Foundation
public extension IADSB {
    public class Barometer: Model,Codable {
        var temperature:Double? = nil
        var pressureAltitude:Double? = nil
        var verticalSpeed:Double? = nil
    }
}
