//
//  Barometer.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/16/18.
//

import Foundation

public protocol IADSBBarometer {
    var temperature:Double? { get }
    var pressureAltitude:Double? { get }
    var verticalSpeed:Double? { get }
}
