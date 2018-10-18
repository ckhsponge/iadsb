//
//  AHRS.swift
//  iADSB
//
//  Created by Christopher Hobbs on 10/16/18.
//

import Foundation

public protocol IADSBAHRS {
    var pitch:Double? { get }
    var roll:Double? { get }
    var headingGyro:Double? { get }
    var headingMagnetic:Double? { get }
    var slipSkid:Double? { get }
    var turnRate:Double? { get }
    var gLoad:Double? { get }
}
